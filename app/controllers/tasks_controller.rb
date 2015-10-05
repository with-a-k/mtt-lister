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

  private

  def task_params
    params.require(:task).permit(:title, :due_date, :description, :task_list_id)
  end
end
