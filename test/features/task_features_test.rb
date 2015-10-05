require 'test_helper'

class TaskFeaturesTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = MTTLister::Application
    Capybara.use_default_driver
    DatabaseCleaner.clean
    reset_session!
  end

  test "create a task" do
    user = User.create(name: "Ein", password: "fivesprite")
    task_list = TaskList.create(title: "Container", user_id: user.id)
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_on "Log In"
    click_on "Container"
    click_on "Add Task"
    fill_in 'Title', with: 'Floor'
    click_on "Create"
    byebug
    assert page.has_content?("Floor")
  end
end