require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email)
    should validate_presence_of(:password)
    should validate_length_of(:password).is_at_least(6)
    should have_secure_password
  end
end
