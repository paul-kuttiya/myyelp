class SessionsController < ApplicationController
  before_action :send_home, except: [:destroy]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.first_name} #{user.last_name}!"
      redirect_to root_path
    else
      flash[:danger] = "Wrong username or password!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil

    flash[:danger] = "Successfully log out!"
    redirect_to root_path
  end
end