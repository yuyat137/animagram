# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to article_path(comment.article), notice: 'コメントを投稿しました'
    else
      redirect_to article_path(comment.article), notice: 'コメントの投稿に失敗しました'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body).merge(article_id: params[:article_id])
    end
end
