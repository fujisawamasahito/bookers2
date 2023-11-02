class UsersController < ApplicationController
  def show
     @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

   def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:alert] = "successfully"
    redirect_to user_path(@user.id)
     else
       flash.now[:alert] = "error"
       render :edit
     end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
