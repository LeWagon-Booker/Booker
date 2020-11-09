class DropOwnershipTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :ownerships
    drop_table :books_wishlists
    add_reference :books, :user, foreign_key: true
  end
end
