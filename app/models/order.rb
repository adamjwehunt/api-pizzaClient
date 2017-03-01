class Order < ApplicationRecord
  # model association
has_many :pizzas, dependent: :destroy

# validations
validates_presence_of :name
end
