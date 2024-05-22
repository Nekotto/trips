class Public::UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page])
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end