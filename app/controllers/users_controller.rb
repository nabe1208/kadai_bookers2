class UsersController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully." #(show)
    else
      #@user = User.find(params[:id])
      render :edit
    end
  end

# show: user_path(user.id) = users/:id
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
