class TaskListsController < ApplicationController
  before_action :authorize!

  def index
    @task_lists = TaskList.belonging_to_user(params[:user_id]).unarchived
  end

  def show
    @task_list = TaskList.find_by(id: params[:id])
  end

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.create(task_list_params)
    if @task_list.save
      flash['success'] = 'Creation successful.'
      redirect_to user_task_list_path(current_user, @task_list)
    else
      flash['critical'] = 'Creation failed.'
      redirect_to new_user_task_list_path(current_user)
    end
  end

  def archived
    @task_lists = TaskList.belonging_to_user(params[:user_id]).archived
  end

  def edit
    @task_list = TaskList.find_by(id: params[:id])
  end

  def update

  end

  def destroy

  end

  private

  def authorize!
    unless params[:user_id] == current_user.id.to_s
      flash['critical'] = 'That belongs to someone else!'
      redirect_to root_path
    end
  end

  def task_list_params
    params.require(:task_list).permit(:title)
  end
end
