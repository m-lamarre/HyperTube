require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Example", first_name: "Example",
                     last_name: "Examples", email: "user@example.com",
                     password: "pass123", password_confirmation: "pass123")
  end

  test "user should be valid" do
    assert @user.valid?
  end


  test "username should be present" do
    @user.username = "     "
    assert_not @user.valid?
  end

  test "first name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "     "
    assert_not @user.valid?
  end


  test "username should not be too long" do
    @user.username = "a" * 21
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.first_name = "a" * 21
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.last_name = "a" * 21
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "password should be at least 6 characters long" do
    @user.password = @user.password_confirmation = "abcde"
    assert_not @user.valid?
  end


  test "username should be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "first name should be unique" do
    duplicate_user = @user.dup
    duplicate_user.first_name = @user.first_name.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "last name should be unique" do
    duplicate_user = @user.dup
    duplicate_user.last_name = @user.last_name.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # test "email addresses should be saved as lower-case" do
  #   mixed_case_email = "Foo@ExAMPle.CoM"
  #   @user.email = mixed_case_email
  #   @user.save
  #   assert_equal mixed_case_email.downcase, @user.reload.email
  # end
end
