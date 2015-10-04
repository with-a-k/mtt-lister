require 'test_helper'

class TaskListFeaturesTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = MTTLister::Application
    DatabaseCleaner.clean
    reset_session!
  end

  test "create a task list" do
    user = User.create(name: "Ein", password: "fivesprite")
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_on "Log In"
  end
end