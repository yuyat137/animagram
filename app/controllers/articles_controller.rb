class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @articles = Article.all.includes(:user).order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: '写真をアップしました'
    else
      flash.now['danger'] = '写真のアップに失敗しました'
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order(created_at: :desc)
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, images: [])
  end
end
