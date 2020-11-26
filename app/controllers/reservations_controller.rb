class ReservationsController < ApplicationController
  def index
    @my_reservations = Reservation.where(user: current_user)
    @my_requests = Reservation.where(book_ownership: current_user.book_ownerships)
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
    @reservation.update!(reservation_params)
    redirect_to dashboard_path(current_user)
  end

  def toggle_confirmation
    @reservation = Reservation.find(params[:format])
    @reservation.toggle_confirmation
    redirect_to dashboard_path(current_user)
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to dashboard_path(current_user)
  end

  def rent_out!
    Reservation.find(params[:id]).rent_out!
  end

  def rent_in!
    Reservation.find(params[:id]).rent_in!
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :message)
  end
end
