class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book_ownership

  validates :start_date, :end_date, presence: true, availability: true
  validate :end_date_after_start_date

  def toggle_confirmation
    confirmed? ? self.confirmed = false : self.confirmed = true
    save!(validate: false)
  end

  def rent_out!
    self.rented     = true
    self.rentedin   = nil
    self.rentedout  = DateTime.current
    save!
  end

  def rent_in!
    self.rented     = false
    self.rentedin   = DateTime.current
    save!
  end

  def rent_reset!
    self.rented     = false
    self.rentedin   = nil
    self.rentedout  = nil
    save!
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
