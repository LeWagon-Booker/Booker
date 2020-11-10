require 'json'
require 'rest-client'
class BooksController < ApplicationController
  GOOGLEKEY = 'AIzaSyBxdETxGjGx8uFm8zq7NokQa1WcXfJ7VeI'
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    @books = Book.all
  end

  def show
    @review = Review.new
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
    params.require(:book).permit(:title, :author, :year, :month, :category, :description, :image_url, :user_id, :cover, :ISBN)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def parse_by_isbn(isbn, params)
    ## Empty hash to store the result
    ## parsing link, supplying ISBN, and GOOGLE KEY from .env file
    source = "https://www.googleapis.com/books/v1/volumes?q=isbn%3D#{isbn}&key=#{GOOGLEKEY}"
    response = RestClient.get source
    json = JSON.parse(response)
    ## adding require results in the result hash
    params[:book][:title] = json["items"][0]["volumeInfo"]["title"]
    params[:book][:author] = json["items"][0]["volumeInfo"]["authors"][0]
    params[:book][:year] = json["items"][0]["volumeInfo"]["publishedDate"]
    params[:book][:description] = json["items"][0]["volumeInfo"]["description"]
    unless json["items"][0]["volumeInfo"]["imageLinks"].nil?
      params[:book][:image_url] = json["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
    else
      params[:book][:image_url] = "https://images.isbndb.com/covers/02/21/#{isbn}.jpg"
      # params[:book][:image_url] = 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80'
    end
    ## returning the result hash
    params
  end
end



