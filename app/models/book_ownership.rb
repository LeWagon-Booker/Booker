class BookOwnership < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :reservations


  def unavailable_dates
    reservations.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
