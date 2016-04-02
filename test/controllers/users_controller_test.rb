require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:colin)
    @other_user = users(:jesica)
  end

  test "should redirect edit if not logged in." do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update if not logged in." do
    patch :update, id: @user, user: { handle: @user.handle,
                                      first_name: @user.first_name,
                                      last_name: @user.last_name,
                                      email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit if wrong user is logged in." do
    log_in_as(@other_user)
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update if wrong user is logged in." do
    log_in_as(@other_user)
    patch :update, id: @user, user: { handle: @user.handle,
                                      first_name: @user.first_name,
                                      last_name: @user.last_name,
                                      email: @user.email }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web." do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password: "password",
                                            password_confirmation: "password",
                                            admin:                 true }
    assert_not @other_user.reload.admin?
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index if not logged in."  do
    get :index
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in." do
    assert_no_difference 'User.count' do
      delete :destroy, id: @other_user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-user." do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url
  end
end
