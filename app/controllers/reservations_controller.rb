class ReservationsController < ApplicationController


  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def create
    @reservation = Reservation.new()
    @reservation.user = current_user
    @reservation.book = Book.find(params[:book_id])
    if @reservation.save
      redirect_to book_path(@reservation.book)
    else
      render :new
    end
  end

end
