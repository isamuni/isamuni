# frozen_string_literal: true
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ilike(attrib, value)
    where(arel_table[attrib].matches("%#{value}%"))
  end

  def self.searchable_language
    'italian'
  end
end
