class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true
  validates :rating, presence: true
  validates :rating, inclusion: 0..5
end
