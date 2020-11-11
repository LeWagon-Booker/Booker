class ChangeConfirmed < ActiveRecord::Migration[6.0]
  def change
    rename_column :reservations, :confirmed?, :confirmed
  end
end
