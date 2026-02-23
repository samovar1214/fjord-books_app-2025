# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_my_comment, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    @comment.save!
    redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  def edit; end

  def update
    @comment.update!(comment_params)
    redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
  end

  def destroy
    @comment.destroy!
    redirect_to @commentable, status: :see_other, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def set_my_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.expect(comment: %i[body])
  end
end
