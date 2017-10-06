class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  has_many :articles
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5}, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true
end
