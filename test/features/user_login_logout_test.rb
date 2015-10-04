require 'test_helper'

class UserLoginLogoutTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = MTTLister::Application
    DatabaseCleaner.clean
    reset_session!
  end

  test "successful login" do
    user = User.create(name: "Ein", password: "fivesprite")
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_on "Log In"
    assert page.has_content?("Ein")
  end

  test "wrong password" do
    user = User.create(name: "Ein", password: "fivesprite")
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: "user.password"
    click_on "Log In"
    assert page.has_content?("Login failed.")
  end

  test "nonexistent user" do
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: "Random User"
    fill_in 'Password', with: "user.password"
    click_on "Log In"
    assert page.has_content?("Login failed.")
  end
end