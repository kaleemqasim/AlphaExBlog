class CategoriesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 12)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params_category)
    if @category.save
      flash[:success] = "Category was successfully created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(params_category)
      flash[:success] = "Category name was successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
    @article_categories = @category.articles.paginate(page: params[:page],per_page: 5)
  end

  def destroy
  end

  private
  def params_category
    params.require(:category).permit(:name)
  end
  def require_admin
    if !current_user.admin?
      flash[:danger] = "You dont have required privileges to create categories"
      redirect_to categories_path
    end
  end
end
