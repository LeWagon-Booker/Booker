class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.book = Book.find(params[:book_id])
    @review.rating = params[:rating]
    @review.user = current_user
    if @review.save
      redirect_to book_path(@review.book)
    else
      @book = Book.find(params[:book_id])
      render 'books/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
