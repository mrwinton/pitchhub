module SecretSharingController
  extend ActiveSupport::Concern

  included do

    databases = SecretSharingHelper.databases
    threshold = SecretSharingHelper.threshold

  end

  private

  def get_discourses(pitch_card, user, page)

    discourses_shares_array = []

    databases.each { |db|
      discourses_shares_array << pitch_card.comments.with(database: db).initiator_content_scoped_for(user).desc(:_id).page( page )
    }

    base_shares_array = discourses_shares_array.delete_at(0)

    discourses_secrets_array = []

    base_shares_array.each { |share|

      discourse_shares = []

      discourse_shares << share

      discourses_shares_array.each { |other_shares_array|

        matching_shares = other_shares_array.select{ |other_share| share.id == other_share.id }

        if matching_shares.size == 0
          matching_share = matching_shares.first
          discourse_shares << matching_share
        else
          raise Error
        end

      }

      if discourse_shares.size > threshold

        if share.class.name == "Suggestion"
          discourse = SecretSharingHelper.decrypt_model(Suggestion.class, discourse_shares)
        else
          discourse = SecretSharingHelper.decrypt_model(Comment.class, discourse_shares)
        end

        discourses_secrets_array << discourse
      else
        put "not enough shares"
      end

    }

    discourses_secrets_array

  end

  def get_pitch_cards_encrypted(user, page)

    db = databases.first

    PitchCard.with(database: db).content_scoped_for(user).desc(:_id).page( page )

  end

  def get_pitch_cards(user, page)

    pitch_cards_shares_array = []

    databases.each { |db|
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

      if pitch_card_shares.size > threshold

        discourse = SecretSharingHelper.decrypt_model(PitchCard.class, pitch_card_shares)

        pitch_cards_secrets_array << discourse
      else
        put "not enough shares"
      end

    }

    pitch_cards_secrets_array

  end

end