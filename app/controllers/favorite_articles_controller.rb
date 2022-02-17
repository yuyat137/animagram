# frozen_string_literal: true

class FavoriteArticlesController < ApplicationController
  def index
    @favorite_articles = current_user.favorite_articles.includes(:user).order(created_at: :desc)
  end
end
