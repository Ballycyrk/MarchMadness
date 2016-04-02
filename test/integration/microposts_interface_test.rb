require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:colin)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, micropost: { content: " " }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "Crazy what cackles when you are away from the hen house."
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, micropost: { content: content, picture: picture }
    end
    assert assigns(:micropost).picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post
    assert_select 'a', text: 'I take it back'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost.id)
    end
    # Visit a different user
    get user_path(users(:jesica))
    assert_select 'a', text: 'I take it back', count: 0
  end

  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} kernels", response.body
    # Users with zero microposts
    other_user = users(:declan)
    log_in_as(other_user)
    get root_path
    assert_match "0 kernels", response.body
    other_user.microposts.create!(content: "I'm dead.")
    get root_path
    assert_match "1 kernel", response.body
  end
end
