class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit
  end

  def index
    @users = User.all
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Chatter, #{@user.username}!"
      redirect_to root_path
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Account was successfully updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil if @user == current_user
      flash[:notice] = "Account was successfully deleted"
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :description)
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only make changes to your own account"
      redirect_to @user
    end
  end
end
