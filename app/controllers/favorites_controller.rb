# frozen_string_literal: true
class FavoritesController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    current_user.favorite(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    current_user.unfavorite(@article)
  end
end
