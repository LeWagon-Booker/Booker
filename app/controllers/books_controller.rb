class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update]
  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    params[:user_id] = current_user
    pp params
    @book = Book.create(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :year, :month, :category, :description, :user_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def parse_by_isbn(isbn)
    result = {}
    source = "https://www.googleapis.com/books/v1/volumes?q=isbn%3D#{isbn}&key=#{GOOGLEKEY}"
    json = JSON.parse(open(source).read, symbolize_names: true)
    result[:title] = json[:items][0][:volumeInfo][:title]
    result[:author] = json[:items][0][:volumeInfo][:authors][0]
    result[:publisher] = json[:items][0][:volumeInfo][:publisher]
    result[:year] = json[:items][0][:volumeInfo][:publishedDate]
    result[:description] = json[:items][0][:volumeInfo][:description]
    result
  end
end
