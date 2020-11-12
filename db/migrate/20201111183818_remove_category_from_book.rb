class RemoveCategoryFromBook < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :category
    add_reference :books, :category, foreign_key: true
  end
end
