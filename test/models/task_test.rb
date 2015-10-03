require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "it has a title" do
    test_task = Task.create(title: "Go on date with Papyrus")
    assert test_task.title
    assert_equal "Go on date with Papyrus", test_task.title
  end

  test "it must have a title" do
    refute Task.create().valid?
  end

  test "it has a due date" do
    test_task = Task.create(title: "Hang out with Napstablook")
    assert test_task.due_date
    assert_equal Date.today, test_task.due_date
  end

  test "it can have a due date that's not today" do
    test_task = Task.create(title: "Stack 80 hot dogs", due_date: "February 4, 2050")
    refute_equal Date.today, test_task.due_date
  end

  test "it has a description" do
    test_task = Task.create(title: "Watch the new Mettaton movie", description: "I've heard it's going to be a blast...")
    assert test_task.description
    assert_equal "I've heard it's going to be a blast...", test_task.description
  end

  test "its description is blank if not provided one" do
    test_task = Task.create(title: "Defuse bomb")
    assert_equal "", test_task.description
  end

  test "it is incomplete by default" do
    test_task = Task.create(title: "SAVE Asriel")
    assert_equal "incomplete", test_task.status
  end

  test "it can be marked as complete" do
    test_task = Task.create(title: "Go back to the Ruins")
    test_task.complete!
    assert_equal "complete", test_task.status
  end

  test "it can be marked as incomplete" do
    test_task = Task.create(title: "Meet someone at Art Club", status: "complete")
    test_task.incomplete!
    assert_equal "incomplete", test_task.status
  end

  test "it can access the task list containing it" do
    test_list = TaskList.create(title: "Daily Hotel Management Tasks")
    test_task = Task.create(title: "Place mints on all pillows", task_list_id: test_list.id)
    assert_equal test_list, test_task.task_list
  end

  test "it can access the user that owns it" do
    test_user = User.create(name: "Temmie", password: "hOI!!")
    test_list = TaskList.create(title: "TEMMIEGENDA", user_id: test_user.id)
    test_task = Task.create(title: "kill muscls", task_list_id: test_list.id)
    assert_equal test_user, test_task.user
  end
end
