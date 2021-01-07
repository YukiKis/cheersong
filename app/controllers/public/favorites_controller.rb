class Public::FavoritesController < ApplicationController
  def create
    @song = Song.find(params[:song_id])
    @song.favorites.create(user_id: current_user.id)
    redirect_to @song
  end
  
  def destroy
    @song = Song.find(params[:song_id])
    favorite = @song.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to @song
  end
end
