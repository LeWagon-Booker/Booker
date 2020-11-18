class UniqBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :image_url
    remove_column :books, :month
    add_column :families, :description, :text
    remove_column :reservations, :book_id
    add_column :book_ownerships, :available, :boolean, default: true
    add_reference :reservations, :book_ownership, foreign_key: true
  end
end
