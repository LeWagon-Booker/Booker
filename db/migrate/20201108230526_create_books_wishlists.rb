class CreateBooksWishlists < ActiveRecord::Migration[6.0]
  def change
    create_table :books_wishlists do |t|
      t.references :wishlist, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
