class AddDescriptionAndYopToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :description, :text
    add_column :books, :year, :integer
    add_column :books, :month, :integer
  end
end
