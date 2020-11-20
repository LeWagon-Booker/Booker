class AvailabilityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    reservations = Reservation.where(["book_ownership_id =?", record.book_ownership_id]).where.not(id: record&.id)
    date_ranges = reservations.map { |b| b.start_date..b.end_date }

    date_ranges.each do |range|
      if range.include? value
        record.errors.add(attribute, "not available")
      end
    end
  end
end
