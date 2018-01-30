class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    @artist = Artist.find_or_create_by(name: params[:song][:artist_name])
    @genre = Genre.find(params[:song][:genre_id])
    @song = Song.new(song_params)
    @contents = invite_params['email']
    @song.note_contents = params[:song][:notes]
    if @song.save
      @song.update(artist: @artist, genre: @genre)
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title)
  end

  def note_params
    params.require(:song).permit(notes:[])
  end
end
