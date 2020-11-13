class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :user
  belongs_to :category
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy

  include PgSearch::Model
  multisearchable against: [:title, :description, :author]

  def unavailable_dates
    reservations.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
