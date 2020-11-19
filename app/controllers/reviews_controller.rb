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

  def destroy
    book = Review.find(params[:id]).book
    Review.find(params[:id]).destroy
    redirect_to book_path(book)
  end

  def update
    review = Review.find(params[:id])
    review.rating = params[:rating] unless params[:rating].nil?
    review.content = params[:review][:content] unless params[:review][:content].nil?
    review.save
    redirect_to book_path(params[:book_id])
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :id, [review: :content], [review: :rating])
  end
end
