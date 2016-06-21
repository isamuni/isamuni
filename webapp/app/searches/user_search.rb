# Search inspired by the following stackoverflow answers:
# http://stackoverflow.com/questions/30019692/in-rails-how-do-i-set-up-the-twitter-typeahead-js-gem-for-rails
# http://stackoverflow.com/questions/28654125/searchkick-bloodhound-typeahead-for-autocomplete

class UserSearch < Searchlight::Search
	extend ActiveModel::Naming
  include ActiveModel::Conversion

  def base_query
  	User.all
  end

  def search_name_like
  	User.where(User.arel_table[:name].matches("%#{name_like}%"))
  end

  def search_typeahead
  	User.where(User.arel_table[:name].matches("%#{typeahead}%"))
  end
end
