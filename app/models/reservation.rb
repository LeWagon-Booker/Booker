class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book
  attr_accessor :confirmed?
end
