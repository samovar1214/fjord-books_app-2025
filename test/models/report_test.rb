# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'ログインユーザーと投稿者が一致する場合、editable?がtrueを返すこと' do
    user = create(:user)
    report = create(:report, user: user)

    assert report.editable?(user)
  end

  test 'ログインユーザーと投稿者が一致しない場合、editable?がfalseを返すこと' do
    user = create(:user)
    report = create(:report, user: user)
    other_user = create(:user)

    assert_not report.editable?(other_user)
  end

  test 'created_onが投稿日を返すこと' do
    report = create(:report, created_at: Time.zone.parse('2026-03-24 00:00:00'))
    assert_equal Date.new(2026, 3, 24), report.created_on
  end

  def create_mention
    @report = create(:report)
    @mentioning_report = create(:report, content: "http://localhost:3000/reports/#{@report.id}を見ました。")
  end

  test '日報に他の日報のURLが含まれる場合、言及先として保存されること' do
    create_mention
    assert_includes @mentioning_report.mentioning_reports, @report
  end

  test 'さらに他の日報のURLを追記して更新した場合、言及先も更新されること' do
    create_mention
    another_report = create(:report)
    @mentioning_report.update!(content: "http://localhost:3000/reports/#{@report.id}とhttp://localhost:3000/reports/#{another_report.id}を見ました。")

    assert_includes @mentioning_report.mentioning_reports, @report
    assert_includes @mentioning_report.mentioning_reports, another_report
  end

  test '日報から他の日報のURLが削除された場合、言及関係も消えること' do
    create_mention
    @mentioning_report.update!(content: 'URLを削除しました。')

    assert_empty @mentioning_report.reload.mentioning_reports
  end

  test '自身を言及できないこと' do
    report = create(:report)
    report.update!(content: "http://localhost:3000/reports/#{report.id}は自分の日報です。")

    assert_empty report.mentioning_reports
  end

  test '言及先の日報が削除された場合、言及関係も消えること' do
    create_mention
    @report.destroy

    assert_empty @mentioning_report.reload.mentioning_reports
  end
end
