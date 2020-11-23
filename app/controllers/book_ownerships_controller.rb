class BookOwnershipsController < ApplicationController
  def new
    BookOwnership.create!(book_id: set_params[:book_id], user: current_user)
    redirect_to book_path(set_params[:book_id])
  end

  private

  def set_params
    params.permit(:book_id)
  end
end
