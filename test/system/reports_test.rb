# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @report = create(:report, user: @user)

    visit root_path
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test '日報を作成できること' do
    visit reports_path
    click_on '日報の新規作成'
    fill_in 'タイトル', with: '新しい日報'
    fill_in '内容', with: 'モデルテストを書きました。'
    click_on '登録する'
    assert_text '日報が作成されました。'
    assert_text '新しい日報'
  end

  test '日報を更新できること' do
    visit report_path(@report)
    click_on 'この日報を編集'
    fill_in 'タイトル', with: '編集された日報'
    fill_in '内容', with: 'システムテストを書きました。'
    click_on '更新する'
    assert_text '日報が更新されました。'
    assert_text '編集された日報'
  end

  test '日報を削除できること' do
    visit report_path(@report)
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
    assert_no_text '編集された日報'
  end
end
