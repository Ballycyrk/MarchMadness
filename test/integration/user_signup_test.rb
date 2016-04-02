require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid login information" do
  get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { handle: "",
                               first_name: "",
                               last_name: "",
                               email: "foo@bar",
                               password: "foo",
                               password_confirmation: "bar"}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid login information with account activation" do
  get signup_path
  assert_difference 'User.count', 1 do
    post users_path, user: { handle: "Studly",
                             first_name: "Example",
                             last_name: "User",
                             email: "foo@bar.com",
                             password: "foobar",
                             password_confirmation: "foobar"}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    # Index Page
    #Login as Valid User
    log_in_as(users(:colin))
    # Unactivated user is on the second page
    get users_path, page: 2
    assert_no_match user.handle, response.body
    #Profile page
    get user_path(user)
    assert_redirected_to root_url
    #Logout as Valid User
    delete logout_path
    # Invaild activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    #Valid token, wrong email.
    get edit_account_activation_path(user.activation_token, email: "nope")
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
