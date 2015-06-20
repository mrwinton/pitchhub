class ContributorsDisclosureScope < Scope

  # Disclosed to myself and the collaborators + initiator

  def is_in_scope(user, content_creator)
    user.id == content_creator.id
  end

  def is_in_pitch_card_scope(user, pitch_card)
    is_in_scope(user, pitch_card.initiator)
  end

  def is_in_comment_scope(user, comment)
    if is_in_scope(user, comment.author) or is_in_scope(user, comment.pitch_point.pitch_card.initiator)
      true
    else

      is_collaborator = false

      comment.pitch_point.pitch_card.collaborators.each { |collaborator|
        if is_in_scope(user, collaborator)
          is_collaborator = true
        end
      }

      is_collaborator

    end
  end

end