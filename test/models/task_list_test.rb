require 'test_helper'

class TaskListTest < ActiveSupport::TestCase
  test "it has a name" do
    test_list = TaskList.create(title: "Determination Experiments")
    assert test_list.title
    assert_equal "Determination Experiments", test_list.title
  end

  test "it must have a name" do
    refute TaskList.create().valid?
  end

  test "it starts unarchived" do
    test_list = TaskList.create(title: "TV Show Minigames")
    assert_equal false, test_list.archived
  end

  test "it can be archived" do
    test_list = TaskList.create(title: "Puns to Make")
    test_list.archive!
    assert_equal true, test_list.archived
  end

  test "it can access its user" do
    test_user = User.create(name: "Frisk", password: "determination")
    test_list = TaskList.create(title: "Monsters to Spare", user_id: test_user.id)
    assert_equal test_user, test_list.user
  end
end
