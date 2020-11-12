class Family < ApplicationRecord
  has_one_attached :picture
  has_many :adhesions, dependent: :destroy
  has_many :users, through: :adhesions
end
