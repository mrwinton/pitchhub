class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    # PitchCard auth abilities

    can :see_initiator, PitchCard do |pitch_card|
      pitch_card.identity_scope.is_in_pitch_card_scope(user, pitch_card)
    end

    can :read_pitch, PitchCard do |pitch_card|
      pitch_card.content_scope.is_in_pitch_card_scope(user, pitch_card)
    end

    can :manage, PitchCard do |pitch_card|
      pitch_card.initiator.id == user.id
    end

    # PitchPoint comments auth abilities

    can :see_author, Comment do |comment|
      comment.identity_scope.is_in_comment_scope(user, comment)
    end

    can :read_content, Comment do |comment|
      comment.content_scope.is_in_comment_scope(user, comment)
    end

    can :manage, Comment do |comment|
      comment.author.id == user.id
    end

    # PitchPoint suggestion auth abilities

    can :accept_suggestion, Suggestion do |suggestion|
      suggestion.pitch_point.pitch_card.initiator.id == user.id
    end

  end
end
