# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_my_comment, only: %i[edit update destroy]

  def create
    @comment = Report.find(params[:report_id]).comments.new(comment_params)
    @comment.user = current_user

    @comment.save!
    redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  def edit
    render 'comments/edit'
  end

  def update
    @comment.update!(comment_params)
    redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
  end

  def destroy
    @comment.destroy!
    redirect_to @comment.commentable, status: :see_other, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_my_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.expect(comment: %i[body])
  end
end
