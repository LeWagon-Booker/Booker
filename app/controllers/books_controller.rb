require 'json'
require 'rest-client'
require 'open-uri'

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @book = Book.new
    @user_families = current_user.families
    @no_result = false
    if params[:search].present?
      do_global_search
    else
      my_books
    end
  end

  def show
    @reservation = Reservation.new
    @review = Review.new
    @book_ownerships = @book.book_ownerships
    if Review.where(book_id: @book.id).empty?
      @avg_rating = "No ratings yet"
    else
      book_reviews_rating = Review.where(book_id: @book.id).map(&:rating)
      @avg_rating = (book_reviews_rating.sum(0.0) / book_reviews_rating.size).round(2)
    end
    @wishlist = Wishlist.where(user_id: current_user, book_id: @book.id)
  end

  def new
    @book = Book.new
  end

  def create
    if params[:book][:title].nil?
      isbn_params = parse_by_isbn(params[:book][:ISBN], params)
      if isbn_params.is_a? String
        @book = Book.new
        render :new
      end
      if Book.find_by(ISBN: isbn_params[:parameters][:ISBN]).nil?
        file = URI.open(isbn_params[:file])
        @book = Book.new(isbn_params[:parameters])
        @book.cover.attach(io: file, filename: 'cover.png', content_type: 'image/png')
      else
        @book = Book.find_by ISBN: isbn_params[:parameters][:ISBN]
      end
    else
      @book = Book.new(book_params)
      @book.category = Category.find(params[:book][:category_id])
    end
    if @book.save
      if params[:book][:wishlist] == "1"
        Wishlist.create(book: @book, user: current_user)
      else
        BookOwnership.create(book: @book, user: current_user)
      end
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy
    book_ownership = BookOwnership.find_by(book_id: @book.id, user_id: current_user.id)
    book_ownership.destroy
    redirect_to books_path
  end

  def update
    @book.update(book_params)
    redirect_to book_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :year, :category_id, :description, :user, :cover, :ISBN)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def parse_by_isbn(isbn, params)
    response = RestClient.get "https://www.googleapis.com/books/v1/volumes?q=isbn%3D#{isbn}&key=#{ENV['GOOGLEKEY']}"
    i = 0
    10.times do
      i += 1
      file = JSON.parse(response)
      break if file["totalItems"].positive?
    end
    return "No book found. Please enter it manually" if i >= 10

    json = JSON.parse(response)["items"][0]["volumeInfo"]
    params[:book][:title] = json["title"]
    params[:book][:author] = json["authors"][0]
    params[:book][:year] = json["publishedDate"]
    params[:book][:description] = json["description"]
    params[:book][:ISBN] = isbn
    json["imageLinks"].nil? ? params[:book][:image_url] = "https://images.isbndb.com/covers/02/21/#{isbn}.jpg" : params[:book][:image_url] = json["imageLinks"]["thumbnail"]
    { parameters: params.require(:book).permit(:title, :author, :year, :description, :ISBN, :category_id), file: params[:book][:image_url] }
  end

  def do_global_search
    @books = Book.all
    @books = Book.includes(:category, cover_attachment: :blob).global_search(params[:search][:term]) if params[:search][:term].present?
    @books = @books.where(category_id: params[:search][:category]) if params[:search][:category].present?
    @books = current_user.families.select{|fam| fam.id == params[:search][:families].to_i }.flat_map(&:books).uniq & @books if params[:search][:families].present?
    @no_result = true if @books.size.zero?
    @books = my_books if @books.size.zero?
  end

  def my_books
    @books = []
    @user_families.each do |family|
      @books << family.users.includes(books: [:category, cover_attachment: :blob]).flat_map(&:books)
      @books = @books.flatten.uniq
    end
    @books
  end
end
