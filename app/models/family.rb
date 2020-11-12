class Family < ApplicationRecord
  has_many :adhesions
  has_many :users, through: :adhesions
end
