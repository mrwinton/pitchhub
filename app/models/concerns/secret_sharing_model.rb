module SecretSharingModel
  extend ActiveSupport::Concern

  included do

    databases = SecretSharingHelper.databases
    threshold = SecretSharingHelper.threshold

    # Load Scopable Instance Methods
    include Scopable::InstanceMethods

  end

  module InstanceMethods

    # CRUD operations
    def secret_save

      model_instance = self
      model_shares = SecretSharingHelper.encrypt_model(self.class, model_instance)

      databases.each_with_index { |db, index|

        share = model_shares[index]

        if share.with(database: db).save
          #   success
        else
          # errors, so return the model instance with the errors that were found
          model_instance.errors = share.errors
          return model_instance
        end
      }

      model_instance

    end

    def secret_update
      self.secret_save
    end

    def secret_delete

      id = self.id

      databases.each { |db|
        model = self.class.with(database: db).find(id)
        model.destroy
      }

    end

  end

  # methods defined here are going to extend the class, not the instance of it
  module ClassMethods

    def secret_find(model_id)

      model_shares = []

      databases.each { |db|
        model_shares << self.class.with(database: db).find(model_id)
      }

      model = SecretSharingHelper.decrypt_model(self.class, model_shares)

    end

  end

end