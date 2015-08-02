module SecretSharingController
  extend ActiveSupport::Concern

  private

  def get_initiated(user, page)

    db = SecretSharingHelper.databases.first

    PitchCard.with(database: db).where("initiator_id" => { "$eq" => user.id }).desc(:_id).page( page )

  end

  def get_collaborated(user, page)

    db = SecretSharingHelper.databases.first

    collab_cards = user.collab_pitch_cards

    collab_cards_ids = []

    collab_cards.each { |card|
      collab_cards_ids << card.id
    }

    PitchCard.with(database: db).where("_id" => { "$in" => collab_cards_ids }).desc(:_id).page( page )

  end

  def get_discourses(pitch_card, user, page)

    discourses_shares_array = []

    SecretSharingHelper.databases.each { |db|
      # discourses_shares_array << pitch_card.comments.with(database: db).initiator_content_scoped_for(user).desc(:_id).page( page )
      discourses_shares_array << Comment.with(database: db).where(pitch_card_id: pitch_card.id).initiator_content_scoped_for(user).desc(:_id).page( page )
    }

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

      if discourse_shares.size > SecretSharingHelper.threshold

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

    db = SecretSharingHelper.databases.first

    PitchCard.with(database: db).content_scoped_for(user).desc(:_id).page( page )

  end

  def get_pitch_cards(user, page)

    pitch_cards_shares_array = []

    SecretSharingHelper.databases.each { |db|
      pitch_cards_shares_array << PitchCard.with(database: db).content_scoped_for(user).desc(:_id).page( page )
    }

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