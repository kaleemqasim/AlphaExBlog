class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 12)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(params_users)
    if @user.save
      flash[:success] = "Accout has been successfully created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_users)
      flash[:success] = "User profile was successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
  def params_users
    params.require(:user).permit(:username, :email, :password)
  end
  def require_same_user
    if (!current_user.admin? && !current_user == @user)
      flash[:danger] = "You can only perform actions on your profile/articles"
      redirect_to root_path
    end
  end

end
