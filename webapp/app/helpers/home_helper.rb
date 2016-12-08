# frozen_string_literal: true
module HomeHelper
  def post_icon(post_type)
    case post_type
    when 'link'
      'fa-link'
    when 'event'
      'fa-calendar'
    when 'photo'
      'fa-photo'
    else
      'fa-sticky-note-o'
    end
  end
end
