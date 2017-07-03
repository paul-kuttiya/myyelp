class UsersController < ApplicationController
  before_action :send_home, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Yelp Clone!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def create_user
    params.require(:user).permit!
  end
end