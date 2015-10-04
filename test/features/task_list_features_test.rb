require 'test_helper'

class TaskListFeaturesTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = MTTLister::Application
    Capybara.use_default_driver
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

  test "shows only unarchived tasklists in index" do
    user = User.create(name: "Ein", password: "fivesprite")
    task_list = TaskList.create(title: 'You Should See Me', user_id: user.id)
    archived_list = TaskList.create(title: "You Shouldn't See Me", user_id: user.id, archived: true)
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_on "Log In"
    assert page.has_content?('You Should See Me')
    refute page.has_content?("You Shouldn't See Me")
  end

  test "shows only archived tasklists in archive" do
    user = User.create(name: "Ein", password: "fivesprite")
    task_list = TaskList.create(title: 'I Am Not Archived', user_id: user.id)
    archived_list = TaskList.create(title: "I Am Archived", user_id: user.id, archived: true)
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_on "Log In"
    click_on "Archived Task Lists"
    refute page.has_content?('I Am Not Archived')
    assert page.has_content?("I Am Archived")
  end
end