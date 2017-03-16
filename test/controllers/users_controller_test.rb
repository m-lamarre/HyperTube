require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new user registration path" do
    get new_user_registration_path
    assert_response :success
  end
end
