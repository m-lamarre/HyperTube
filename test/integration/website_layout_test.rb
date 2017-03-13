require 'test_helper'

class WebsiteLayoutTest < ActionDispatch::IntegrationTest
  test "website layout links" do
    get root_path
    assert_select "a[href=?]", root_path, count: 4
    assert_select "a[href=?]", "/users/sign_in", count: 2
    assert_select "a[href=?]", "/users/sign_up", count: 2
    # assert_select "a[href=?]", browse_movies_path, count: 2
    get new_user_registration_path
    assert_select "title", full_title("Sign Up")
    get new_user_session_path
    assert_select "title", full_title("Sign In")
    get new_user_password_path
    assert_select "title", full_title("Forgot Password")
  end
end
