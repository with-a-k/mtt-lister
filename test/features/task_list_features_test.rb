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
    click_on "New Task List"
    fill_in 'Title', with: 'To-Watch List'
    click_on "Create"
    assert page.has_content?("To-Watch List")
  end

  test "without a title" do
    user = User.create(name: "Ein", password: "fivesprite")
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_on "Log In"
    click_on "New Task List"
    click_on "Create"
    assert_equal new_user_task_list_path(user), current_path
    assert page.has_content?("Creation failed.")
  end
end