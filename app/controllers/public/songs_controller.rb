class Public::SongsController < ApplicationController
  def index
    @songs = Song.includes(:favorites).all
  end
  
  def show
    @song = Song.find(params[:id])
  end
  
  def new
    @song = Song.new
    @address = Address.new
  end
  
  def create
    @song = current_user.songs.new(song_params)
    if @song.save
      address = @song.addresses.new(address_params)
      if address.save
        redirect_to song_path(@song)
      else
        render :new
      end
    else
      render :song
    end
  end
  
  private
    def song_params
      params.require(:song).permit(:name, :description)
    end
    
    def address_params
      params.require(:address).permit(:name, :url)
    end
end
