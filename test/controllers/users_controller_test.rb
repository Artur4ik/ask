require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tom)
  end

  test "signed in user see feed" do
    sign_in(@user)
    get(user_feed_path)
    assert_equal(request.path, user_feed_path)
    assert(response.ok?)
  end

  test "signed out user can't visit feed page" do
    get(user_feed_path)
    assert_equal(request.path, user_feed_path)
    assert_equal(response.code, "302")
    assert_redirected_to(root_path)
  end

  test "signed in user can see my profile buttons" do
    sign_in(@user)
    get(user_feed_path)
    assert_select("a[href=?]", user_questions_path(user_id: @user.id), count: 3)
    assert_template('users/feed')
  end

  test "signed in user can see feed buttons" do
    sign_in(@user)
    get(user_feed_path)
    assert_select("a[href=?]", user_feed_path, count: 2)
    assert_template('users/feed')
  end

  test "signed in user can see common feed buttons" do
    sign_in(@user)
    get(user_feed_path)
    assert_select("a[href=?]", users_path)
    assert_template('users/feed')
  end

end
