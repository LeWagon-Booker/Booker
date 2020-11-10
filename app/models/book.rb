class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
