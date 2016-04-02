require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:colin)
  end

  test "unsuccessful edits" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { handle: "",
                                    first_name: "",
                                    last_name: "",
                                    email: "foo@bar",
                                    password: "foo",
                                    password_confirmation: "bar"}
    assert_template 'users/edit'
  end

  test "successful edits with friendly fowarding" do
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    handle = "Mr. C"
    first_name = "Colin James"
    last_name = "McKenna"
    email = "colin@example.com"
    patch user_path(@user), user: { handle: handle,
                                    first_name: first_name,
                                    last_name: last_name,
                                    email: email,
                                    password: " ",
                                    password_confirmation: " " }
    assert_not flash.empty?
    assert_redirected_to @user
    assert_nil session[:fowarding_url]
    @user.reload
    assert_equal @user.handle, handle
    assert_equal @user.first_name, first_name
    assert_equal last_name, @user.last_name
    assert_equal email, @user.email
  end
end
