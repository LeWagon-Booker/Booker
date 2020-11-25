class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @user = User.find(params[:user_id])
    @books = BookOwnership.where(user_id: @user.id).map(&:book)
    @wishlist = Wishlist.where(user_id: @user.id).map(&:book)
    @reviews = Review.where(user_id: @user.id)
    sql_query = " \
      adhesions.user_id = :query \
    "
    @families = Adhesion.joins(:family).where(sql_query, query: @user.id).map(&:family)
    @my_reservations = Reservation.where(user: current_user)
    @my_requests = Reservation.where(book_ownership: current_user.book_ownerships)
  end
end
