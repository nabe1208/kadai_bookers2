class BooksController < ApplicationController

# index: books_path = /books
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

# create: books_path = /books
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully." # 詳細へ
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @user = @book.user
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

# show: book_path = books/:id
  def show
    #redirect_to books_url if @book.blank? #追記
    @books = Book.all
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
  end

# destroy: book_path  =books/:id
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end