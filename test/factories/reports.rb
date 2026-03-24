# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'テストの日報' }
    content { '今日はテストデータを作りました。' }
    association :user
  end
end
