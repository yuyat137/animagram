# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to article_path(comment.article), notice: t('defaults.success', item: Comment.model_name.human)
    else
      redirect_to article_path(comment.article), notice: t('defaults.fail', item: Comment.model_name.human)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to article_path(@comment.article), notice: t('defaults.deleted', item: Comment.model_name.human)
  end

  private

    def comment_params
      params.require(:comment).permit(:body).merge(article_id: params[:article_id])
    end
end
