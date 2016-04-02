require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "March Madness - Dog Mugy Style"
    assert_equal full_title("Help"), "Help | March Madness - Dog Mugy Style"
  end
end
