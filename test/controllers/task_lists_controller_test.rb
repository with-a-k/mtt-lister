require 'test_helper'

class TaskListsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get archived" do
    get :archived
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end
end
