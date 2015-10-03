class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:user][:password] != params[:user][:re_password]
      flash['critical'] = "Your passwords need to match!"
      redirect_to :back
    else
      new_user = User.create(name: params[:user][:name], password: params[:user][:password])
      session[:user_id] = new_user.id
      flash['success'] = "Registration was successful."
      redirect_to root_path
    end
  end
end
