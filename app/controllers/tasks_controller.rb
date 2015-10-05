class TasksController < ApplicationController
  def new
    @task = Task.new(task_list_id: params[:task_list_id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash['success'] = 'Creation successful.'
      redirect_to user_task_list_path(current_user, params[:task_list_id])
    else
      flash['critical'] = 'Creation failed.'
      redirect_to new_user_task_list_task_path(current_user, params[:task_list_id])
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update!(task_params)
    redirect_to user_task_list_path(current_user, @task.task_list)
  end

  def complete
    @task = Task.find_by(id: params[:id])
    @task.complete!
    @task.save!
    redirect_to user_task_list_path(current_user, @task.task_list)
  end

  def uncomplete
    @task = Task.find_by(id: params[:id])
    @task.incomplete!
    @task.save!
    redirect_to user_task_list_path(current_user, @task.task_list)
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_date, :description, :task_list_id)
  end
end
