require 'test_helper'

class Api::V1::TasksControllerTest < ActionController::TestCase
  def setup
    @user = User.create(name: 'Sol Badguy', password: 'wants2breakfree')
    @task_list = TaskList.create(title: "Bustin' Gears", user_id: @user.id)
    @task = Task.create(title: 'Justice', description: 'Yep. Her again.', task_list_id: @task_list.id)
    @token = @user.token
  end

  test "no token" do
    get :index, format: :json, user_id: @user.id
    assert_response :forbidden

    get :show, format: :json, user_id: @user.id, id: @task_list.id
    assert_response :forbidden
  end

  test "wrong token" do
    get :index, format: :json, user_id: @user.id, token: 'gdi ky'
    assert_response :forbidden

    get :show, format: :json, user_id: @user.id, id: @task_list.id, token: 'gdi ky'
    assert_response :forbidden
  end

  test "wrong user" do
    subuser = User.create(name: 'Ky Kiske', password: 'ridethelightning')
    sublist = TaskList.create(title: 'Upholding Justice', user_id: subuser.id)
    subtask = Task.create(title: 'Find Sol', task_list_id: sublist.id)
    get :index, format: :json, user_id: subuser.id, token: @token
    assert_response :forbidden

    get :show, format: :json, user_id: subuser.id, id: subtask.id, token: @token
    assert_response :forbidden
  end

  test "#index" do
    get :index, format: :json, user_id: @user.id, token: @token
    assert_response :success
    tasks = JSON.parse(response.body, symbolize_names: true)
    assert_equal 1, tasks.count
  end

  test "#show" do
    get :show, format: :json, user_id: @user.id, token: @token, id: @task.id
    assert_response :success
    retrieved_task = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Justice", retrieved_task[:title]
    assert_equal "Yep. Her again.", retrieved_task[:description]
  end
end
