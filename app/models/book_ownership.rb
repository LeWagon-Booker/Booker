class BookOwnership < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :reservations
end
