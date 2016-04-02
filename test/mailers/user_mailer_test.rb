require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:colin)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Activate this thing called Madness.", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["ballycyrk@gmail.com"], mail.from
    assert_match user.first_name,         mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user =users(:colin)
    user.reset_token = User.new_token
    mail =UserMailer.password_reset(user)
    assert_equal "Write it down next time.", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["ballycyrk@gmail.com"], mail.from
    assert_match user.first_name,         mail.body.encoded
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
end
