class WishlistsController < ApplicationController

  def index
    @wishlists = Wishlist.where(user_id: current_user.id)
  end


  def create
    @wishlist = Wishlist.new
    @wishlist.book = Book.find(params[:book_id])
    @wishlist.user = current_user
    @wishlist.save
    redirect_to wishlists_path
  end

  def destroy
    wishlist = Wishlist.find(params[:id])
    wishlist.destroy
    redirect_to wishlists_path
  end

  private

  def set_wishlist
  end

end
