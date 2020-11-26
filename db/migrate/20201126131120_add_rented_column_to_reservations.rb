class AddRentedColumnToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :rented, :boolean, default: false
    add_column :reservations, :rentedout, :datetime
    add_column :reservations, :rentedin, :datetime
  end
end
