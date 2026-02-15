# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        @comments = @commentable.comments.includes(:user)
        format.html { render "#{@commentable.class.model_name.plural}/show", status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        @comments = @commentable.comments.includes(:user)
        format.html { render "#{@commentable.class.model_name.plural}/show", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to @commentable, status: :see_other, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def correct_user
    redirect_to @commentable, alert: 'Not authorized.' unless @comment.user == current_user
  end

  def comment_params
    params.expect(comment: %i[body])
  end
end
