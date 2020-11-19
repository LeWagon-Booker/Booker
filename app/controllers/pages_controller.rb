class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @user = current_user
    @books = BookOwnership.where(user_id: @user.id).map(&:book)
    @wishlist = Wishlist.where(user_id: @user.id).map(&:book)
    @reviews = Review.where(user_id: @user.id)
    sql_query = " \
      adhesions.user_id = :query \
    "
    @families = Adhesion.joins(:family).where(sql_query, query: current_user.id).map(&:family)
  end
end
