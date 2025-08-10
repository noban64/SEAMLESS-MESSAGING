require "test_helper"

class MessageControllerTest < ActionDispatch::IntegrationTest
  test "should get send" do
    get message_send_url
    assert_response :success
  end
end
