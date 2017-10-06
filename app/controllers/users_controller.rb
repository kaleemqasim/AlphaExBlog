class UsersController < ApplicationController
  before_action :set_params, except: [:index, :new, :create]
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
      session[:user_id] = @user.id
      flash[:success] = "Accout has been successfully created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(params_users)
      flash[:success] = "User profile was successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    if @current_user == @user
      session[:user_id] = nil
      @user.destroy
      flash[:success] = "You've successfully deleted your account and logged out"
      redirect_to root_path
    else
      @user.destroy
      flash.now[:success] = "You have successfully deleted the account"
      redirect_to users_path
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

  def set_params
    @user = User.find(params[:id])
  end
end
