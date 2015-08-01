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

        # for testing purposes
        is_new = share.new_record?

        success = share.with(database: db).save

        if success
          #   success
        else
          # errors, so return the model instance with the errors that were found
          return plain_instance

        end
      }

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