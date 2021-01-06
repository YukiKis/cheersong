class Public::MessagesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @room = @user.rooms.find(params[:room_id])
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to user_room_path(@user, @room)
    else
      render "public/rooms/show"
    end
  end
  
  private
    def message_params
      params.require(:message).permit(:content, :room_id)
    end
end
