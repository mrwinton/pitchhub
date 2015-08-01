module SecretSharingHelper

  def self.databases
    ["pitchhub_ci", "pitchhub_vuw", "pitchhub_aws"]
  end

  def databases
    SecretSharingHelper.databases
  end

  def self.threshold
    2
  end

  def threshold
    SecretSharingHelper.threshold
  end

  # Secret Sharing operations
  def self.split_secret(secret)

    # databases.count = n, threshold = k
    secret_containter = SecretSharing::Shamir::Container.new(databases.count,threshold)

    secret_containter.secret = SecretSharing::Shamir::Secret.new(:secret => secret)

    secret_containter.shares

  end

  def split_secret(secret)
    SecretSharingHelper.split_secret(secret)
  end

  def self.combine_secret_shares(shares)

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

  def combine_secret_shares(shares)
    SecretSharingHelper.combine_secret_shares(shares)
  end

  # Model operations

  def self.encrypt_model(model, model_instance)

    # Comment to encrypt:
    #   comment
    # Suggestion to encrypt:
    #   content

    model.split(model_instance, databases.length)

  end

  def self.decrypt_model(model, model_shares)

    model.combine(model_shares)

  end

  def encrypt_model(model, model_instance)
    SecretSharingHelper.encrypt_model(model, model_instance)
  end

  def decrypt_model(model, model_shares)
    SecretSharingHelper.decrypt_model(model, model_shares)
  end


end