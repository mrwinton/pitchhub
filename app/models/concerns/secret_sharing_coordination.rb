module SecretSharingCoordination
  extend ActiveSupport::Concern

  included do

    databases = ["pitchhub_ci", "pitchhub_vuw", "pitchhub_aws"]
    threshold = 2

    # Load Scopable Instance Methods
    include Scopable::InstanceMethods

  end

  module InstanceMethods

    # CRUD operations
    def secret_save(model)

      model_shares = encrypt_model(model)

      databases.each_with_index { |db, index| model_shares[index].with(database: db).save }

    end

    def secret_find(model_class, model_id)

      model_shares = []

      databases.each { |db|
        model_shares << model_class.with(database: db).find(model_id)
      }

      model = decrypt_model(model_shares)

    end

    def secret_update(model)
      secret_save(model)
    end

    def secret_delete(model_class, model_id)

      databases.each { |db|
        model = model_class.with(database: db).find(model_id)
        model.destroy
      }

    end

    # Model operations
    def encrypt_model(model)
      # model.attributes.attributes.each do |name, value|
      # PitchCard to encrypt:
      #   all pitch points except value proposition (embedded)
      # Comment to encrypt:
      #   comment
      # Suggestion to encrypt:
      #   content

      model.split
    end

    def decrypt_model(model_shares)

    end

    # Secret Sharing operations
    def split_secret(secret)

      # databases.count = n, threshold = k
      secret_containter = SecretSharing::Shamir::Container.new(databases.count,threshold)

      secret_containter.secret = SecretSharing::Shamir::Secret.new(:secret => secret)

      secret_containter.shares

    end

    def combine_secret_shares(shares)

      # databases.count = n, threshold = k
      secret_containter = SecretSharing::Shamir::Container.new(databases.count,threshold)

      shares.each { |share|
        secret_containter << share
      }

      if secret_containter.secret?
        return secret_containter.secret
      else
        raise new Error
      end

    end

  end

end