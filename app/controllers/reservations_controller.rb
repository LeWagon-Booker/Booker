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
    @reservation.start_date = Time.new(params[:reservation]['start_date(1i)'], params[:reservation]['start_date(2i)'], params[:reservation]['start_date(3i)'], params[:reservation]['start_date(4i)'], params[:reservation]['start_date(5i)'])
    @reservation.end_date = Time.new(params[:reservation]['end_date(1i)'], params[:reservation]['end_date(2i)'], params[:reservation]['end_date(3i)'], params[:reservation]['end_date(4i)'], params[:reservation]['end_date(5i)'])
    @reservation.message = params[:reservation]['message']
    if @reservation.save
      redirect_to book_path(@reservation.book)
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
    @reservation.save
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :message)
  end
end
