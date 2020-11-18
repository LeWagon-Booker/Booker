class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :category
  has_many :book_ownerships, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :book_ownerships

  include PgSearch::Model
  multisearchable against: [:title, :description, :author]

end
