class Api::V1::TaskListsController < ApplicationController
  respond_to :json
  before_action :authorize!

  def index
    respond_with TaskList.where(user_id: params[:user_id])
  end

  def show
    respond_with TaskList.find_by(id: params[:id])
  end

  private

  def authorize!
    unless User.find_by(id: params[:user_id]).token == params[:token]
      head :forbidden
    end
  end
end
