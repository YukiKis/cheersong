class Public::RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms.all
  end

  def show
    @room = current_user.has_room?(@user)
  end
  
  def create
    user = User.find(params[:user_id])
    room = Room.create
    room.users << [current_user, user]
    redirect_to user_room_path(room)
  end
end
