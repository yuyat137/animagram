class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = Article.all.includes(:user).order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: '記事を作成しました'
    else
      flash.now['notice'] = '記事の作成に失敗しました'
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: '記事を更新しました'
    else
      flash.now[:danger] = '記事の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, notice: '記事を削除しました'
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, images: [])
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end
end
