module SecretSharingController
  extend ActiveSupport::Concern

  private

  def get_initiated(user, page)

    db = SecretSharingHelper.databases.reject{ |db| db[:type] == "sql" }.first

    # PitchCard.with(database: db[:name]).where("initiator_id" => { "$eq" => user.id }).desc(:_id).page( page )
    PitchCard.with(session: db[:name]).where("initiator_id" => { "$eq" => user.id }).desc(:_id).page( page )

  end

  def get_collaborated(user, page)

    db = SecretSharingHelper.databases.reject{ |db| db[:type] == "sql" }.first

    collab_cards = user.collab_pitch_cards

    collab_cards_ids = []

    collab_cards.each { |card|
      collab_cards_ids << card.id
    }

    # PitchCard.with(database: db[:name]).where("_id" => { "$in" => collab_cards_ids }).desc(:_id).page( page )
    PitchCard.with(session: db[:name]).where("_id" => { "$in" => collab_cards_ids }).desc(:_id).page( page )

  end

  def get_discourses(pitch_card, user, page)

    discourses_shares_array = []

    SecretSharingHelper.databases.reject{ |db| db[:type] == "sql" }.each { |db|
      # discourses_shares_array << Comment.with(database: db[:name]).where(pitch_card_id: pitch_card.id).initiator_content_scoped_for(user).desc(:_id).page( page )
      discourses_shares_array << Comment.with(session: db[:name]).where(pitch_card_id: pitch_card.id).initiator_content_scoped_for(user).desc(:_id).page( page )
    }

    if discourses_shares_array.any?
      SecretSharingHelper.databases.reject{ |db| db[:type] == "mongo" }.each { |db|

        alt_discourse_shares = []

        pitch_card_id = pitch_card.id.to_s
        # find instances given the id
        # alt_model_shares = ActiveRecordComment.where(:pitch_card_id => pitch_card_id).using(db[:name])
        first_shares = discourses_shares_array.first

        clazz = ActiveRecordComment

        alt_model_shares = clazz.using(db[:name]).where(pitch_card_id: pitch_card_id)

        alt_model_shares.each do |alt_model_share|

          matching_mongoid_models = first_shares.select{ |share|
            share.id.to_s == alt_model_share.object_id
          }

          base_mongoid_model = matching_mongoid_models.first

          # convert it into a mongoid share
          model_share = alt_model_share.to_mongoid_model base_mongoid_model
          # add the converted shares to the results
          alt_discourse_shares << model_share
        end

        discourses_shares_array << alt_discourse_shares

      }
    end


    base_shares_array = discourses_shares_array.delete_at(0)

    discourses_secrets_array = []

    base_shares_array.each { |share|

      discourse_shares = []

      discourse_shares << share

      discourses_shares_array.each { |other_shares_array|

        matching_shares = other_shares_array.select{ |other_share| share.id == other_share.id }

        # check that we found one and only one matching share
        if matching_shares.size == 1
          # get the share
          matching_share = matching_shares.first
          # add it to our shares array for this discourse
          discourse_shares << matching_share
        else
          raise Error
        end

      }

      if discourse_shares.size >= SecretSharingHelper.threshold

        if share.class.name == "Suggestion"

          discourse = SecretSharingHelper.decrypt_model(Suggestion, discourse_shares)
        else
          discourse = SecretSharingHelper.decrypt_model(Comment, discourse_shares)
        end

        discourses_secrets_array << discourse
      else
        # TODO throw warning?
        # not enough shares
      end

    }

    discourses_secrets_array

  end

  def get_pitch_cards_encrypted(user, page)

    db = SecretSharingHelper.databases.reject{ |db| db[:type] == "sql" }.first

    # PitchCard.with(database: db[:name]).content_scoped_for(user).desc(:_id).page( page )
    PitchCard.with(session: db[:name]).content_scoped_for(user).desc(:_id).page( page )

  end

  def get_pitch_cards(user, page)

    pitch_cards_shares_array = []

    SecretSharingHelper.databases.reject{ |db| db[:type] == "sql" }.each { |db|
      # pitch_cards_shares_array << PitchCard.with(database: db[:name]).content_scoped_for(user).desc(:_id).page( page )
      pitch_cards_shares_array << PitchCard.with(session: db[:name]).content_scoped_for(user).desc(:_id).page( page )
    }
    # TODO
    # SecretSharingHelper.databases.reject{ |db| db[:type] == "mongo" }.each { |db|
    #
    #   # get the record's class
    #   clazz = self.active_record_class
    #   # find instances given the id
    #   alt_model_share = clazz.using(db[:name]).find_by(object_id: model_id)
    #   # convert it into a mongoid share
    #   model_share = alt_model_share.to_mongoid_model model_shares.first
    #   # add the converted shares to the results
    #   model_shares << model_share
    # }

    base_shares_array = pitch_cards_shares_array.delete_at(0)

    pitch_cards_secrets_array = []

    base_shares_array.each { |share|

      pitch_card_shares = []

      pitch_card_shares << share

      pitch_cards_shares_array.each { |other_shares_array|

        matching_shares = other_shares_array.select{ |other_share| share.id == other_share.id }

        if matching_shares.size == 0
          matching_share = matching_shares.first
          pitch_card_shares << matching_share
        else
          raise Error
        end

      }

      if pitch_card_shares.size > SecretSharingHelper.threshold

        discourse = SecretSharingHelper.decrypt_model(PitchCard, pitch_card_shares)

        pitch_cards_secrets_array << discourse
      else
        put "not enough shares"
      end

    }

    pitch_cards_secrets_array

  end

end