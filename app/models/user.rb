# frozen_string_literal: true

class User < ApplicationRecord
  ACCEPTED_CONTENT_TYPES = ['image/jpeg', 'image/png', 'image/gif'].freeze

  has_one_attached :icon
  validates :icon, content_type: ACCEPTED_CONTENT_TYPES

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
