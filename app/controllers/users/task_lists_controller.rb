# class Users::TaskListsController < ApplicationController
#   def index
#     @task_lists = TaskList.belonging_to_current_user.unarchived
#   end

#   def show
#     @task_list = TaskList.find_by(id: params[:id])
#   end

#   def new
#     @task_list = TaskList.new
#   end

#   def create

#   end

#   def archived
#     @task_lists = TaskList.belonging_to_current_user.archived
#   end

#   def edit
#     @task_list = TaskList.find_by(id: params[:id])
#   end

#   def update

#   end

#   def destroy

#   end
# end
