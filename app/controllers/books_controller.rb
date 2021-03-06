class BooksController < ApplicationController
  before_action :auth_token_check
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
    set_owner_myself

    if @book.save
      render json: @book, status: 201
    else
      render json: @book, status: 500
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book, status: 500
    end
  end

  def destroy
    if @book.destroy
      render nothing: true, status: 204
    else
      render nothing: true, status: 500
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :isbn, :owner)
    end

    def set_owner_myself
      @book[:owner] = current_user.id unless book_params.include?("owner")
    end
end
