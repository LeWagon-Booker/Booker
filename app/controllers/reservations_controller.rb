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
    @reservation.book_ownership = BookOwnership.find(params[:book_ownership_id])
    @reservation.start_date = Date.parse(params[:reservation]['start_date'])
    @reservation.end_date = Date.parse(params[:reservation]['end_date'])
    @reservation.message = params[:reservation]['message']
    if @reservation.save
      redirect_to book_path(@reservation.book_ownership.book)
    else
      render :new
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.confirmed?
      @reservation.confirmed = false
    else @reservation.confirmed = true
    end
    @reservation.save(validate: false)
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :message)
  end
end
