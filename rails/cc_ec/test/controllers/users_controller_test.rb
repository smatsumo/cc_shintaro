require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get profiles" do
    get users_profiles_url
    assert_response :success
  end

end
