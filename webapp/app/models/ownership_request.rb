# frozen_string_literal: true
class OwnershipRequest < ApplicationRecord
  belongs_to :page
  belongs_to :user
end
