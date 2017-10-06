class ArticlesController < ApplicationController
  before_action :getting_params, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 12)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params_article)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params_article)
      flash[:success] = "Article was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private
    def params_article
      params.require(:article).permit(:title, :description, category_ids: [])
    end
    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "You can only perform actions on your profile/articles"
        redirect_to root_path
      end
    end

    def getting_params
      @article = Article.find(params[:id])
    end
end
