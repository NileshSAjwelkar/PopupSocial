class User < ApplicationRecord
  has_secure_password
  attr_accessor :password_confirmation
  act_as_mentionee
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  validates :username, uniqueness: true

  has_many :posts
  has_many_attached :uploads
end
