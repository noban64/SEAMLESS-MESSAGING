require "test_helper"

class FriendControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get friend_list_url
    assert_response :success
  end
end
