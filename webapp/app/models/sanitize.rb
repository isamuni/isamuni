module Sanitize

  def Sanitize.encode str
      return str.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end

end
