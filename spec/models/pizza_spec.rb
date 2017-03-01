require 'rails_helper'

RSpec.describe Pizza, type: :model do
  # Association test
  # ensure a pizza record belongs to a single order record
  it { should belong_to(:order) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
