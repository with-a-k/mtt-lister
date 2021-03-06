class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:user][:password] != params[:user][:re_password]
      flash['critical'] = "Your passwords need to match!"
      redirect_to :back
    else
      new_user = User.create(user_params)
      session[:user_id] = new_user.id
      flash['success'] = "Registration was successful."
      redirect_to user_task_lists_path(new_user)
    end
  end

  def token
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
