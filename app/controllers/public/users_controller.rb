class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end
  
  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to @user
  end
  
  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to @user
  end
  
  def followers
    @user = User.find(params[:id])
    count = @user.followers.count
    @title = "#{ count } #{ "follower".pluralize(count) }"
    @users = @user.followers
    render "public/users/follow"
  end
  
  def followings
    @user = User.find(params[:id])
    count = @user.followings.count
    @title = "#{ count } #{ "following".pluralize(count) }"
    @users = @user.followings
    render "public/users/follow"
  end
end
