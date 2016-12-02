class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ilike(attrib, value)
  	where(self.arel_table[attrib].matches("%#{value}%"))
  end

  def self.searchable_language
    'italian'
  end
end
