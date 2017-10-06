class Article < ActiveRecord::Base
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 5}
end
