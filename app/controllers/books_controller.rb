require 'json'
require 'rest-client'
require 'open-uri'
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    @book = Book.new
    sql_query = " \
      adhesions.user_id = :query \
    "
    @user_families = Adhesion.joins(:family).where(sql_query, query: current_user.id).map do |adhesion|
      adhesion.family
    end

    if params[:search].present?
      #my_books_var = my_books
      # filtered = do_search
      # filtered.select { |book| my_books_var.include?(book)}
      do_search
    else
      @no_result = false
      my_books
    end
    if params[:family].present?
      @books=[]
      family = Family.find(params[:family])
      family.users.each do |user|
        user.books.each do |book|
          @books << book unless @books.include?(book)
        end
      end
    end

  end

  def show
    @reservation = Reservation.new
    @review = Review.new
    @book_ownership = @book.book_ownerships[0]
    if Review.where(book_id: @book.id).empty?
      @avg_rating = "No ratings yet"
    else
      book_reviews_rating = Review.where(book_id: @book.id).map do |review|
        review.rating
      end
      @avg_rating = book_reviews_rating.sum(0.0) / book_reviews_rating.size
      @avg_rating = @avg_rating.round(2)
    end
  end

  def new
    @book = Book.new
  end

  def create
    new_params = parse_by_isbn(params[:book][:ISBN], params) if params[:book][:title].nil?
    puts new_params
    params[:book][:ISBN] = ""
    file = URI.open(new_params[:book][:image_url])
    @book = Book.new(book_params)
    @book.cover.attach(io: file, filename: 'cover.png', content_type: 'image/png')
    @book.user = current_user
    if @book.save!
      redirect_to book_path(@book)
      PgSearch::Multisearch.rebuild(Book)
    else
      render :new
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
    PgSearch::Multisearch.rebuild(Book)
  end

  def update
    @book.update(book_params)
    redirect_to book_path(@book)
    PgSearch::Multisearch.rebuild(Book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :year, :month, :category_id, :description, :image_url, :user_id, :cover, :ISBN)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def parse_by_isbn(isbn, params)
    ## Empty hash to store the result
    ## parsing link, supplying ISBN, and GOOGLE KEY from .env file
    source = "https://www.googleapis.com/books/v1/volumes?q=isbn%3D#{isbn}&key=#{ENV['GOOGLEKEY']}"
    response = RestClient.get source
    json = JSON.parse(response)
    ## adding require results in the result hash
    params[:book][:title] = json["items"][0]["volumeInfo"]["title"]
    params[:book][:author] = json["items"][0]["volumeInfo"]["authors"][0]
    params[:book][:year] = json["items"][0]["volumeInfo"]["publishedDate"]
    params[:book][:description] = json["items"][0]["volumeInfo"]["description"]
    params[:book][:category] = json["items"][0]["volumeInfo"]["categories"]
    unless json["items"][0]["volumeInfo"]["imageLinks"].nil?
      params[:book][:image_url] = json["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
    else
      params[:book][:image_url] = "https://images.isbndb.com/covers/02/21/#{isbn}.jpg"
    end
    ## returning the result hash
    puts params
    params
  end

  def do_search
    @books = []
    @object = PgSearch.multisearch(params[:search]).each do |result|
      @books << Book.find(result[:searchable_id])
      @books
      # my_books_var = my_books
      # puts @books.select {|book| my_books_var.include?(book)}
    end
    @no_result = true if @books.size.zero?
    @books = my_books if @books.size.zero?
  end

  def my_books
    @books = []
    @user_families.each do |family|
      family.users.each do |user|
        user.books.each do |book|
          @books << book unless @books.include?(book)
        end
      end
    end
    @books
  end












end
