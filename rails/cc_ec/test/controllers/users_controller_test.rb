require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get profiles" do
    get :sign_in
    assert_template :sign_in
    assert_template layout: "layouts/application_not_login"
  end

end
