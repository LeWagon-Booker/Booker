class AddReferenceToWishlist < ActiveRecord::Migration[6.0]
  def change
    add_reference :wishlists, :book, foreign_key: true
  end
end
