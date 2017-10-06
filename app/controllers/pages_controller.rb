class PagesController < ApplicationController
  def new
  end

  def about
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You've successfully logged in as #{user.username}"
      redirect_to root_path
    else
      flash[:danger] = "Something is wrong with your credentials."
      redirect_to login_path
    end
  end

end
