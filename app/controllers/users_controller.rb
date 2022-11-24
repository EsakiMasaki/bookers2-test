class UsersController < ApplicationController
  def index
    @user = User.find_by(id: current_user.id)
    @book = Book.new(user_id: @user.id)
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new(user_id: @user.id)
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:introduction,:profile_image)
  end
end
