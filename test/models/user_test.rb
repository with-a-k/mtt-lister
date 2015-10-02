require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "it has a name" do
    test_user = User.create(name: "Alphys", password: "I<3Undyne")
    assert test_user.name
    assert_equal "Alphys", test_user.name
  end

  test "it can't be created without a name" do
    refute User.create(password: "brokenspacetime").valid?
  end

  test "it has a password" do
    test_user = User.create(name: "Papyrus", password: "spaghetti")
    assert test_user.password_digest
  end

  test "it must have a password" do
    refute User.create(name: "Temmie").valid?
  end

  test "its password is not saved plain" do
    test_user = User.create(name: "Sans", password: "skele-ton")
    refute_equal "skele-ton", test_user.password_digest
  end

  test "it can access its tasklists" do
    test_user = User.create(name: "Chara", password: "thefallenone")
    test_list = TaskList.create(title: "Monsters to Kill", user_id: test_user.id)
    assert test_user.task_lists.include?(test_list)
  end
end
