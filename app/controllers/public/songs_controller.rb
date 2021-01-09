class Public::SongsController < ApplicationController
  def index
    @songs = Song.includes(:favorites).all
  end
  
  def show
    @song = Song.find(params[:id])
    @comment = Comment.new
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
  
  def edit
    @song = Song.find(params[:id])
    if @song.user != current_user
      redirect_to song_path(@song), notice: "cannnot edit other's song"
    end
  end
  
  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      redirect_to song_path(@song), notice: "successfully updated"
    else
      render :edit
    end
  end
  
  private
    def song_params
      params.require(:song).permit(:name, :description, :tag_list)
    end
    
    def address_params
      params.require(:address).permit(:name, :url)
    end
end
