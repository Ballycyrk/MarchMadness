require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(handle: "Foobar", first_name: "Example", last_name: "User",
                    email: "example@user.com", password: "billybutton",
                    password_confirmation: "billybutton")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "handle should be present" do
    assert @user.handle = " "
    assert_not @user.valid?
  end

  test "first_name should be present" do
    assert @user.first_name = " "
    assert_not @user.valid?
  end

  test "last_name should be present" do
    assert @user.last_name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    assert @user.email = " "
    assert_not @user.valid?
  end

  test "handle should not be too long" do
    assert @user.handle = "a" * 81
    assert_not @user.valid?
  end

  test "first_name should not be too long" do
    assert @user.first_name = "a" * 81
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    assert @user.last_name = "a" * 81
    assert_not @user.valid?
  end

  test "email should not be too long" do
    assert @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be lowercase" do
    mixed_case_email = "Example@UsER.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "handle should be unique" do
    duplicate_user = @user.dup
    duplicate_user.handle = @user.handle.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be valid" do
    valid_addresses = %w[example@user.com examp.le@user.com USER+dog@example.ie
                      ____@example.email.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email should not be invalid" do
    invalid_addresses = %w[example@user,com user_at_example.com
                          user.name@example. user@foo_bar.com foo@bar+bax.com
                           foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "feed should have right posts" do
    colin  = users(:colin)
    lucia  = users(:lucia)
    jesica = users(:jesica)
    # Posts from followed user.
    lucia.microposts.each do |posts_follower|
      assert colin.feed.include?(posts_follower)
    end
    # Posts from self
    colin.microposts.each do |post_self|
      assert colin.feed.include?(post_self)
    end
    # Posts for unfollowed user.
    jesica.microposts.each do |post_unfollowed|
      assert_not colin.feed.include?(post_unfollowed)
    end
  end
end
