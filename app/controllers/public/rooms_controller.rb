class Public::RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms.all
    
  end

  def show
    @room = Room.includes(:messages).find(params[:id])
    @user = @room.users.find(params[:user_id])
    @message = Message.new
  end
  
  def create
    user = User.find(params[:user_id])
    room = Room.create
    room.users << [current_user, user]
    redirect_to user_room_path(user, room)
  end
end
