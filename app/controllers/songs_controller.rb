class SongsController < ApplicationController

  before_filter :authenticate_user, :except => []
  before_filter :ensure_user_is_editor, :except => [:show, :index]

  def create
    @song = Song.create(song_params)

    if @song.save
      flash[:success] = 'Successfully created new song.'
      redirect_to @song
    else
      render 'new'
    end
  end

  def destroy
  end

  def edit
    @song = Song.find params[:id]
  end

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def update
    @song = Song.find params[:id]

    if @song.update song_params
      flash[:success] = 'Song updated.'
      redirect_to @song
    else
      render 'edit'
    end
  end

  def show
    @song = Song.find params[:id]
  end

  private
    def song_params
      params.require(:song).permit(
        :artist,
        :title,
        :content,
        :key,
        :youtube
      )
    end
end
