class AddIsbnToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :ISBN, :integer
  end
end
