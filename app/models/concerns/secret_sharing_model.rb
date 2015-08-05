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

        if is_new
          success = share.with(database: db).save
        else
          share.new_record = false
          success = share.with(database: db).update
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
        model = self.class.with(database: db).find(id)
        model.destroy
      }

    end

  end

  # methods defined here are going to extend the class, not the instance of it
  module ClassMethods

    def secret_find(model_id)

      model_shares = []

      SecretSharingHelper.databases.each { |db|
        model_shares << self.with(database: db).find(model_id)
      }

      model = SecretSharingHelper.decrypt_model(self, model_shares)

    end

  end

end