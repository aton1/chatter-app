class SessionsController < ApplicationController
  before_action :user_logged_in?, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      session[:user_id]= user.id
      flash[:notice] = "Logged in successfully"
      redirect_to root_path
    else
      flash.now[:alert] = "Username or password entered is incorrect"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to login_path
  end

  private

  def user_logged_in?
    if logged_in?
      flash[:alert] = "You are already logged in"
      redirect_to root_path
    end
  end
end
