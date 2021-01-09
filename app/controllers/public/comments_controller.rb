class Public::CommentsController < ApplicationController
  def create
    @song = Song.find(params[:song_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to song_path(@song), notice: "successfully made a comment" 
    else
      render "public/songs/show", @song
    end
  end
  
  def destroy
    @song = Song.find(params[:song_id])
    Comment.find(params[:id]).destroy
    redirect_to song_path(@song)
  end
  
  private
    def comment_params
      params.require(:comment).permit(:song_id, :content)
    end
end
