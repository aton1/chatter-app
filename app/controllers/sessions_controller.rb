class SessionsController < ApplicationController
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
    redirect_to root_path
  end
end
