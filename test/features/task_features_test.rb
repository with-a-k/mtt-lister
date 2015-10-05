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
    assert page.has_content?("Floor")
  end

  test "edit a task" do
    user = User.create(name: "Ein", password: "fivesprite")
    task_list = TaskList.create(title: "Container", user_id: user.id)
    task = Task.create(title: "Side Wall", task_list_id: task_list.id)
    visit root_path
    click_on "Log In"
    assert_equal login_path, current_path
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_on "Log In"
    click_on "Container"
    click_on "Edit Task"
    fill_in 'Title', with: 'Floor'
    fill_in 'Description', with: 'Nothing to support those walls yet.'
    click_on "Edit"
    assert page.has_content?("Floor")
    assert page.has_content?('Nothing to support those walls yet.')
  end

  # Can't run, relies on JS

  # test "complete a task" do
  #   user = User.create(name: "Ein", password: "fivesprite")
  #   task_list = TaskList.create(title: "Container", user_id: user.id)
  #   task = Task.create(title: "Side Wall", task_list_id: task_list.id)
  #   visit root_path
  #   click_on "Log In"
  #   fill_in 'Username', with: user.name
  #   fill_in 'Password', with: user.password
  #   click_on "Log In"
  #   click_on "Container"
  #   click_on "Finish Task"
  #   assert_equal "complete", Task.find_by(id: task.id).status
  # end
end