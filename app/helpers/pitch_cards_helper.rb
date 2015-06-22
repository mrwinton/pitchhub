module PitchCardsHelper

  def is_selected(pitch_card, pitch_point_model, point)

    (not pitch_card.new_record? and pitch_point_model.selected) or (pitch_card.new_record? and point[:selected])

  end

  def is_deselected(pitch_card, pitch_point_model, point)

    (not pitch_card.new_record? and not pitch_point_model.selected) or (pitch_card.new_record? and not point[:selected] and point[:optional])

  end

  def scope_option_attributes(scope)
    {
        :value => scope[:id]
    }
  end

  def is_selected_scope(s, scope)

    if scope.instance_of? s[:scope].class
      if scope.instance_of? GroupDisclosureScope
        # check that the scopes have the same group id
        scope.group.id == s[:id]
      else
        # must be a Generic scope e.g. public or member so return true
        true
      end
    end


  end

  def options_for_select(scopes, scope)
    scopes.map do |s|
      tag_options = scope_option_attributes(s)
      if scope != nil and is_selected_scope(s, scope)
        tag_options[:selected] = "selected"
      end
      content_tag "option", s[:name], tag_options
    end
  end

end
