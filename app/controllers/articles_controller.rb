# frozen_string_literal: true

class ArticlesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  before_action :set_article, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.includes(:user).order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      image_rekognition(@article.image)
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
      flash.now[:notice] = '記事の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, notice: '記事を削除しました'
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :image)
    end

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def image_rekognition(object)
      Aws.config.update({
                          region: 'ap-northeast-1',
                          credentials: Aws::Credentials.new(Rails.application.credentials.aws[:access_key_id],
                                                            Rails.application.credentials.aws[:secret_access_key])
                        })

      rekognition = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])
      @uri = @article.image.service_url
      dir = @uri.split('/').fourth
      key = dir.split('?').first
      response = rekognition.detect_labels({
                                             image: {
                                               s3_object: {
                                                 bucket: 'photo-app-0207',
                                                 name: key
                                               }
                                             }
                                           })
      first_label = response.labels.first
      Rails.logger.debug("#{first_label.name} #{first_label.confidence}")
    end
end
