class AddDatesToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :start_date, :datetime
    add_column :reservations, :end_date, :datetime
    add_column :reservations, :message, :text
  end
end
