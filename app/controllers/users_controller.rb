class UsersController < ApplicationController
  def new
     @book = Book.new(book_params)
  end
  def show
     @book = Book.new
     @user = User.find(params[:id])
    @books = @user.books
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end


  def index
    @book = Book.new
    @users = User.all
    @user= current_user
  end

  def edit
      is_matching_login_user
    @user = User.find(params[:id])

  end

   def update
       is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:alert] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
       flash.now[:alert] = "error"
       render :edit
    end
   end

   # フォロー一覧
    def follows
      user = User.find(params[:id])
      @users = user.following_users
    end

    # フォロワー一覧
    def followers
      user = User.find(params[:id])
      @user = user.follower_users
    end



  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
