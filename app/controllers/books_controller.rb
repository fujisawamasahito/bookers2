class BooksController < ApplicationController
   def new
    @book = Book.new
    @new_book = Book.new
  end

   # 投稿データの保存
  def create
    @user= current_user

      @new_book = Book.new(book_params)
      @books = Book.all
      @book = Book.new(book_params)

    @book.user_id = current_user.id
    if @book.save
        flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
        flash.now[:notice] = "error"
      render :index
    end
  end


    def index
      @book = Book.new
      @user= current_user
      to = Time.current.at_end_of_day
      from = (to - 6.day).at_beginning_of_day
      @books = Book.includes(:favorites).sort_by { |book| -book.favorites.where(created_at: from...to).count }
    end






  def show
      @new_book = Book.new
    @book =  Book.find(params[:id])
    @user= current_user
     @book_comment = BookComment.new

  end

  def edit

    @book = Book.find(params[:id])

    unless @book.user.id == current_user.id
      redirect_to books_path
    end
    @user= current_user
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:alert] = "You have updated book successfully."
    redirect_to book_path(@book.id)
     else
       flash.now[:alert] = "error"
       render :edit
     end
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

