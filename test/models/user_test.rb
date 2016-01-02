require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not create user with the same name" do
  	users(:user_one)
    user = User.new(name: "user_one")
    assert user.invalid?
    assert_equal ["has already been taken"] ,user.errors[:name]
  end

  test "should not create user with empty name" do
    user = User.new(name: nil)
    assert user.invalid?
    assert_equal ["can't be blank"] ,user.errors[:name]
  end
end
