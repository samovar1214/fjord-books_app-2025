# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = create(:book)
    @user = create(:user)

    visit root_path
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test '本を作成できること' do
    visit books_url
    click_on '本の新規作成'
    fill_in 'タイトル', with: '変身'
    fill_in 'メモ', with: '個人に対する不条理を描いています。'
    fill_in '著者', with: 'カフカ'
    attach_file '画像', Rails.root.join('test/fixtures/files/book_blue.png')
    click_on '登録する'
    assert_text '本が作成されました。'
    assert_text '変身'
    assert_selector 'img'
  end

  test '本を更新できること' do
    visit book_path(@book)
    click_on 'この本を編集'
    fill_in 'タイトル', with: 'ペスト'
    fill_in 'メモ', with: '集団に対する不条理を描いています。'
    fill_in '著者', with: 'カミュ'
    attach_file '画像', Rails.root.join('test/fixtures/files/book_red.png')
    click_on '更新する'
    assert_text '本が更新されました。'
    assert_text 'ペスト'
    assert_selector 'img'
  end

  test '本を削除できること' do
    visit book_path(@book)
    click_on 'この本を削除'
    assert_text '本が削除されました。'
    assert_no_text @book.title
  end
end
