require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", full_title("Home")
  end
end
