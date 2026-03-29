# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_emailが名前を返すこと' do
    user = build(:user, name: 'Alice')
    assert_equal 'Alice', user.name_or_email
  end

  test '名前が登録されていない場合はname_or_emailがメールアドレスを返すこと' do
    user = build(:user, email: 'alice@example.com', name: nil)
    assert_equal 'alice@example.com', user.name_or_email
  end
end
