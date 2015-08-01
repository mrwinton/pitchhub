module DiscoursesHelper

  def self.comment_max_length
    500
  end

  def comment_max_length
    DiscoursesHelper.comment_max_length
  end

  def suggestion_status_label(suggestion)

    label_class = nil
    label_value = nil

    case suggestion.status
      when :pending
        label_class = "label-info pitch-card-status-label pulsating"
        label_value = "pending"
      when :accepted
        label_class = "label-success"
        label_value = "accepted"
      when :rejected
        label_class = "label-danger"
        label_value = "rejected"
      else
        label_class = "label-default"
        label_value = "mystery"
    end

    html = "<span class=\"label " + label_class + "\">" + label_value + "</span>"

    return html.html_safe

  end

end
