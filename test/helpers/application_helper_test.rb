require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title("Home"),    "Home | HyperTube"
    assert_equal full_title("Sign Up"), "Sign Up | HyperTube"
    assert_equal full_title("Sign In"), "Sign In | HyperTube"
  end
end
