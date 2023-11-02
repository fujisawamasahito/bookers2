class BooksController < ApplicationController
   def new
    @book = Book.new
  end

   # 投稿データの保存
  def create
      @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
        flash[:notice] = "Book was successfully created."
      redirect_to books_path
    else
        flash.now[:notice] = "error"
      render :index
    end
  end

   def index
    @book = Book.new
    @books = Book.all

  end

  def show
    @book =  Book.find(params[:id])

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

    # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
