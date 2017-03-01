class Pizza < ApplicationRecord
  # model association
  belongs_to :order

  # validation
  validates_presence_of :name
end
