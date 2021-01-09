class Public::UsersController < ApplicationController
  def index
    @users = User.all
    @rooms = current_user.rooms.all
  end

  def show
    @user = User.find(params[:id])
    if @user != current_user
      @room = current_user.has_room?(@user)
    end
  end

  def edit
  end
  
  def follow
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_to @user
  end
  
  def unfollow
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    redirect_to @user
  end
  
  def followers
    @user = User.find(params[:user_id])
    count = @user.followers.count
    @title = "#{ count } #{ "follower".pluralize(count) }"
    @users = @user.followers
    render "public/users/follow"
  end
  
  def followings
    @user = User.find(params[:user_id])
    count = @user.followings.count
    @title = "#{ count } #{ "following".pluralize(count) }"
    @users = @user.followings
    render "public/users/follow"
  end
end
