class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    @books = Book.all
    render json: @books
  end

  def show
    render json: @book
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book
    else
      render json: @book, status: 404
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book, status: 404
    end
  end

  def destroy
    if @book.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 404
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :isbn)
    end
end
