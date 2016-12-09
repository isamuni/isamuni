# frozen_string_literal: true
module Sanitize
  def self.encode(str)
    str
    # return str.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end
end
