require 'test_helper'

class Api::V1::TaskListsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(name: 'Jin Kisaragi', password: 'icecar')
    @task_list = TaskList.create(title: "Major's Tasks", user_id: @user.id)
    @token = @user.token
  end

  test "no token" do
    get :index, format: :json, user_id: @user.id
    assert_response :forbidden

    get :show, format: :json, user_id: @user.id, id: @task_list.id
    assert_response :forbidden
  end

  test "wrong token" do
    get :index, format: :json, user_id: @user.id, token: 'NIIIII-SAAAAAAN'
    assert_response :forbidden

    get :show, format: :json, user_id: @user.id, id: @task_list.id, token: 'NIIIII-SAAAAAAN'
    assert_response :forbidden
  end

  test "wrong user" do
    subuser = User.create(name: 'Ragna the Bloodedge', password: 'azuredrive')
    sublist = TaskList.create(title: 'NOL Branches to Destroy', user_id: subuser.id)
    get :index, format: :json, user_id: subuser.id, token: @token
    assert_response :forbidden

    get :show, format: :json, user_id: subuser.id, token: @token, id: sublist.id
    assert_response :forbidden
  end

  test "#index" do
    get :index, format: :json, user_id: @user.id, token: @token
    assert_response :success
    task_lists = JSON.parse(response.body, symbolize_names: true)
    assert_equal 1, task_lists.count
  end

  test "#show" do
    get :show, format: :json, user_id: @user.id, token: @token, id: @task_list.id
    assert_response :success
    retrieved_list = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Major's Tasks", retrieved_list[:title]
  end
end
