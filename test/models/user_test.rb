require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user attributes must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:username].any?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
  end

  test "user attributes must be unique" do
    first_user = users(:one)
    second_user = users(:two)
    assert first_user.invalid?
    assert first_user.errors[:username].any?
    assert first_user.errors[:email].any?
  end

  test "user email must be properly formed" do
    third_user = users(:three)
    assert third_user.invalid?
    assert third_user.errors[:email].any?
  end
end
