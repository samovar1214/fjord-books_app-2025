# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'Railsでテストを書く本' }
    memo { '面白いです。' }
    author { '著者太郎' }
    picture { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/book_blue.png'), 'image/png') }
  end
end
