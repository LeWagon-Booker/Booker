require 'json'
require 'rest-client'
require 'open-uri'

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @book = Book.new
    sql_query = " \
      adhesions.user_id = :query \
    "
    @user_families = Adhesion.joins(:family).where(sql_query, query: current_user.id).map(&:family)
    if params[:search].present?
      do_search
    else
      @no_result = false
      my_books
    end
    if params[:family].present?
      @books = []
      family = Family.find(params[:family])
      family.users.each { |user| user.books.each { |book| @books << book unless @books.include?(book) } }
    end
  end

  def show
    @reservation = Reservation.new
    @review = Review.new
    @book_ownership = @book.book_ownerships[0]
    if Review.where(book_id: @book.id).empty?
      @avg_rating = "No ratings yet"
    else
      book_reviews_rating = Review.where(book_id: @book.id).map(&:rating)
      @avg_rating = (book_reviews_rating.sum(0.0) / book_reviews_rating.size).round(2)
    end
  end

  def new
    @book = Book.new
  end

  def create
    if params[:book][:title].nil?
      isbn_params = parse_by_isbn(params[:book][:ISBN], params)
      @book = Book.new(isbn_params)
    else
      @book = Book.new(book_params)
      @book.category = Category.find(params[:book][:category_id])
    end
    if @book.save!
      BookOwnership.create(book: @book, user: current_user)
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy
    @book.destroy
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
    json = JSON.parse(response)["items"][0]["volumeInfo"]
    params[:book][:title] = json["title"]
    params[:book][:author] = json["authors"][0]
    params[:book][:year] = json["publishedDate"]
    params[:book][:description] = json["description"]
    params[:book][:category] = json["categories"]
    params[:book][:ISBN] = isbn
    json["imageLinks"].nil? ? params[:book][:image_url] = "https://images.isbndb.com/covers/02/21/#{isbn}.jpg" : params[:book][:image_url] = json["imageLinks"]["thumbnail"]
    params.require(:book).permit(:title, :author, :year, :category_id, :description, :user, :cover, :ISBN)
  end

  def do_search
    @books = []
    @object = PgSearch.multisearch(params[:search]).each { |result| @books << Book.find(result[:searchable_id]) }
    @no_result = true if @books.size.zero?
    @books = my_books if @books.size.zero?
  end

  def my_books
    @books = []
    @user_families.each do |family|
      family.users.each do |user|
        user.books.each { |book| @books << book unless @books.include?(book) }
      end
    end
    @books
  end
end
