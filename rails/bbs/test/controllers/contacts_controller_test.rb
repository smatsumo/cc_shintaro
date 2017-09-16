require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get ask" do
    get contacts_ask_url
    assert_response :success
  end

end
