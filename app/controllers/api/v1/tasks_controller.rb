class Api::V1::TasksController < ApplicationController
  respond_to :json
  before_action :authorize!

  def index
    respond_with Task.where(user_id: params[:user_id])
  end

  def show
    respond_with Task.find_by(id: params[:id])
  end

  private

  def authorize!
    unless User.find_by(id: params[:user_id]).token == params[:token]
      head :forbidden
    end
  end
end
