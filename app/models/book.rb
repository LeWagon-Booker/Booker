class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :user
  belongs_to :category
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy

  include PgSearch::Model
  multisearchable against: [:title, :description, :author]
end
