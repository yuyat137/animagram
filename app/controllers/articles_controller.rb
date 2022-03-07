# frozen_string_literal: true

class ArticlesController < ApplicationController
  skip_before_action :require_login, only: :index
  before_action :set_article, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.includes([:user, :favorites]).order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    if params[:confirm_back]
      @article.image.retrieve_from_cache!(session[:image_cache_name])
    else
      @article = Article.new
    end
  end

  def confirm_category
    @article = current_user.articles.build(article_params)
    if params[:article][:image].present?
      temp_image = TemporaryRekognitionImage.create(source: params[:article][:image])
      @result = image_rekognition(temp_image.source)
    end
    render :new unless valid_except_category(@article)
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.image.retrieve_from_cache! params[:cache][:image]

    if params[:back].present?
      render :new
      return
    end

    if @article.save(validate: false)
      redirect_to articles_path, notice: t('defaults.success', item: Article.model_name.human)
    else
      flash.now['notice'] = t('defaults.faile', item: Article.model_name.human)
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
      redirect_to @article, notice: t('defaults.updated', item: Article.model_name.human)
    else
      flash.now[:notice] = t('defaults.no_updated', item: Article.model_name.human)
      render :edit
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, notice: t('defaults.deleted', item: Article.model_name.human)
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :image, :category_id)
    end

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def valid_except_category(article)
      article.valid?
      article.errors.delete(:category)
      article.errors.empty?
    end

    def image_rekognition(image)
      Aws.config.update({
                          region: 'ap-northeast-1',
                          credentials: Aws::Credentials.new(Rails.application.credentials.aws[:access_key_id],
                                                            Rails.application.credentials.aws[:secret_access_key])
                        })

      rekognition = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])
      response = rekognition.detect_labels({
                                             image: {
                                               s3_object: {
                                                 bucket: 'photo-app-0207',
                                                 name: image.path
                                               }
                                             }
                                           })

      result_label_list = response.labels
      uper_confidence_list = result_label_list.select do |result_label|
        result_label.confidence >= 90
      end

      rekognition_name_list = uper_confidence_list.map(&:name)

      category_name_list = Category.pluck(:rekognition_name)
      rekognition_name_result = 'その他'
      rekognition_name_list.each do |rekogniton_name|
        category = category_name_list.find { |category_name| category_name == rekogniton_name }
        if category.present?
          rekognition_name_result = category
          break
        end
      end

      Category.find_by(rekognition_name: rekognition_name_result)
    end
end
