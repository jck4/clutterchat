require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get auth_error" do
    get pages_auth_error_url
    assert_response :success
  end
end
