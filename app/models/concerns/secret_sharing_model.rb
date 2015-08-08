module SecretSharingModel
  extend ActiveSupport::Concern

  included do

    # Load Scopable Instance Methods
    include SecretSharingModel::InstanceMethods

  end

  module InstanceMethods

    # CRUD operations
    def secret_save

      model_instance = self
      plain_instance = model_instance.dup
      plain_instance.id = model_instance.id #ensure that they still have the same id
      model_shares = SecretSharingHelper.encrypt_model(self.class, model_instance)

      SecretSharingHelper.databases.each_with_index { |db, index|

        share = model_shares[index]

        is_new = self.new_record?

        if db[:type] == "mongo"
          if is_new
            success = share.with(database: db[:name]).save
          else
            share.new_record = false
            success = share.with(database: db[:name]).update
          end
        else
          # else it's sql
          if is_new
            share = share.to_active_record_model
            success = share.save
          else
            share = share.to_active_record_model
            # get the share from the db
            share_from_db = share.class.find_by(object_id: share.object_id)
            # copy any changes across
            share_from_db.update_from(share)
            # save the updated share
            success = share_from_db.save
          end

        end

        if success
          #   success
        else
          # errors, so return the model instance with the errors that were found
          return plain_instance

        end
      }

      # TODO should remove when deployed in production
      # TODO should be avoided by setting one of the dbs as default?
      # required to save the image when developing locally
      self.id = model_shares.first.id
      self.save

      model_shares.first

    end

    def secret_update
      self.secret_save
    end

    def secret_delete

      id = self.id

      SecretSharingHelper.databases.each { |db|
        model = self.class.with(database: db[:name]).find(id)
        model.destroy
      }

    end

  end

  # methods defined here are going to extend the class, not the instance of it
  module ClassMethods

    def secret_find(model_id)

      model_shares = []

      SecretSharingHelper.databases.reject{ |db| db[:type] == "sqlite" }.each { |db|
        model_shares << self.with(database: db[:name]).find(model_id)
      }

      SecretSharingHelper.databases.reject{ |db| db[:type] == "mongo" }.each { |db|

        # get the record's class
        clazz = self.active_record_class
        # find instances given the id
        alt_model_share = clazz.find_by(object_id: model_id)
        # convert it into a mongoid share
        model_share = alt_model_share.to_mongoid_model model_shares.first
        # add the converted shares to the results
        model_shares << model_share
      }

      model = SecretSharingHelper.decrypt_model(self, model_shares)

    end

  end

end