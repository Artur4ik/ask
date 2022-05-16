require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home page" do
    get(home_path)
    assert_equal(request.path, home_path)
    assert(response.ok?)
    assert_template('pages/home')
  end

  test "should get about page" do
    get(about_path)
    assert_equal(request.path, about_path)
    assert(response.ok?)
    assert_template('pages/about')
  end
end
