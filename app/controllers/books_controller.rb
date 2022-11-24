class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new(user_id: current_user.id)
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(current_user)
    else
      render :index
    end
  end

  def show
    @book = Book.new(user_id: current_user.id)
  end

  def edit
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
end
