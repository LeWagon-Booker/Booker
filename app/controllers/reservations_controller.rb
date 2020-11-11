class ReservationsController < ApplicationController
  def index
    @my_reservations = Reservation.where(user_id: current_user.id)
    mybooks_id = Book.where(user_id: current_user.id).map do |book|
      book.id
    end
    @book_reserved = Reservation.where(book_id: mybooks_id)
  end

  def create
    @reservation = Reservation.new
    @reservation.user = current_user
    @reservation.book = Book.find(params[:book_id])
    if @reservation.save
      redirect_to book_path(@reservation.book)
    else
      render :new
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    # @reservation.confirmed?
    # if @reservation.confirmed?
    #   @reservation.confirmed? = false
    # else @reservation.confirmed? = true
    # end
    redirect_to reservations_path
  end
end
