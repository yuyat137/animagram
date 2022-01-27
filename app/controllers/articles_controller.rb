class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @articles = Article.all.includes(:user).order(created_at: :desc)
  end
end
