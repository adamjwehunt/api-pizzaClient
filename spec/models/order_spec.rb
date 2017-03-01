require 'rails_helper'

RSpec.describe Order, type: :model do
  # Association test
  # ensure Order model has a 1:m relationship with the Pizza model
  it { should have_many(:pizzas).dependent(:destroy) }
  # Validation tests
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
