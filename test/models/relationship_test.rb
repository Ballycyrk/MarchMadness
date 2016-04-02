require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: 1, followed_id: 2)
  end

  test "should be valid" do
    @relationship.valid?
  end

  test "should validate follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should validate followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should follow and unfollow a user" do
    colin  = users(:colin)
    jesica = users(:jesica)
    assert_not colin.following?(jesica)
    colin.follow(jesica)
    assert colin.following?(jesica)
    assert jesica.followers.include?(colin)
    colin.unfollow(jesica)
    assert_not colin.following?(jesica)
  end
end
