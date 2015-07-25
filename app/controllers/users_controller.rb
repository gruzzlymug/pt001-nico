class UsersController < ApplicationController
  def home
  end

  def index
    @users = User.all.order(:name)
    render :json => @users
  end

  def show
    @user = User.find(params[:id])
    render :json => @user
  end

end
