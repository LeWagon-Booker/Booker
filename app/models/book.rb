class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :user
end
