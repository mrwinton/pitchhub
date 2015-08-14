module SecretSharingHelper

  def self.databases
    [
        {:name => "pitchhub_mongo_shard_1", :type => "mongo" },
        {:name => "pitchhub_mongo_shard_2", :type => "mongo" },
        {:name => "pitchhub_sql_shard_1", :type => "sql" },
        {:name => "pitchhub_sql_shard_2", :type => "sql" }
    ]
  end

  def databases
    SecretSharingHelper.databases
  end

  def self.threshold
    3
  end

  def threshold
    SecretSharingHelper.threshold
  end

  # Secret Sharing operations
  def self.split_secret(secret)

    # databases.count = n, threshold = k
    n = databases.count
    k = threshold

    # note this lib only works when string is less than 512 bytes in length
    # given ruby's 1 char to 1 byte mapping we are ok given:
    #  - pitchpoint length max = 101
    #  - discourse length max = 500
    shares = ShamirSecretSharing::Base58.split(secret=secret, available=n, needed=k)

    shares

  end

  def split_secret(secret)
    SecretSharingHelper.split_secret(secret)
  end

  def self.combine_secret_shares(shares)

    secret = ShamirSecretSharing::Base58.combine(shares)

    if secret
      return secret
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