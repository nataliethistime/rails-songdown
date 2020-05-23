
require 'songdown_compiler'

class SongsController < ApplicationController
  def create
    @song = current_user.songs.create(song_params)

    if @song.save
      flash[:notice] = 'Successfully created new song.'
      redirect_to @song
    else
      render 'new'
    end
  end

  def destroy
    @song = current_user.songs.find params[:id]
    @song.destroy

    redirect_to songs_path
  end

  def edit
    @song = current_user.songs.find params[:id]
  end

  def index
    query = params[:query]&.strip&.downcase
    @songlist = Song.build_songlist(current_user.songs.search(query))
    @artists = @songlist.keys.sort
  end

  def new
    @song = current_user.songs.new
  end

  def print_song
    handle_show
    render :layout => 'print_song'
  end

  def update
    @song = current_user.songs.find params[:id]

    if @song.update song_params
      flash[:notice] = 'Song updated.'
      redirect_to @song
    else
      render 'edit'
    end
  end

  def show
    handle_show
    IncrementSongViewCounterJob.perform_later @song.id
  end

  private
    def song_params
      params.require(:song).permit(
        :artist,
        :title,
        :content,
        :key,
        :youtube_url
      )
    end

    def handle_show
      @song = current_user.songs.find params[:id]
      @compiler = SongdownCompiler.new(
        :input => @song.content,
        :key => @song.key
      )

      if params[:key]
        @compiler.change_key params[:key]
        @song.key = params[:key]
      end

      @song_key = @compiler.key
      @song_html = @compiler.to_html
    end
end
