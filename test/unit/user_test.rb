require 'test_helper'

class UserTest < ActiveSupport::TestCase
   
  test "should_create_new_user" do
    user = User.new
    assert !user.valid?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
    assert user.errors[:password_digest].any?
    
    assert_equal ["can't be blank", "is invalid"], user.errors[:email]
    assert_equal ["can't be blank"], user.errors[:password]
    assert_equal ["can't be blank"], user.errors[:password_digest]
    assert !user.save
    
  end
end
