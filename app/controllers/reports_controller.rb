# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_my_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params.expect(:id))
  end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.build(report_params)

    @report.save!
    redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
  end

  def update
    @report.update!(report_params)
    redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
  end

  def destroy
    @report.destroy!
    redirect_to reports_path, status: :see_other, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_my_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.expect(report: %i[title body user_id])
  end
end
