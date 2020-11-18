class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :category
  has_many :book_ownerships, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :book_ownerships

  include PgSearch::Model
  multisearchable against: [:title, :description, :author]

  def unavailable_dates
    reservations.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
