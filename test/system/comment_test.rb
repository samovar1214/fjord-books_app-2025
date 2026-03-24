# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)

    visit root_path
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  def post_comment(content)
    fill_in 'comment[content]', with: content
    click_button 'コメントする'
  end

  test '本の画面でコメントを投稿・削除できること' do
    @book = create(:book)

    visit book_path(@book)
    post_comment('こんにちは')
    assert_text 'コメントが作成されました。'
    assert_text 'こんにちは'

    page.accept_confirm do
      click_on '削除'
    end
    assert_text 'コメントが削除されました。'
    assert_no_text 'こんにちは'
  end

  test '日報の画面でコメントを投稿・削除できること' do
    @report = create(:report)

    visit report_path(@report)
    post_comment('こんばんは')
    assert_text 'コメントが作成されました。'
    assert_text 'こんばんは'

    page.accept_confirm do
      click_on '削除'
    end
    assert_text 'コメントが削除されました。'
    assert_no_text 'こんばんは'
  end
end
