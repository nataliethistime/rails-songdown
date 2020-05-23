require 'songdown_compiler'

class ApiController < ApplicationController
  def transpose_song
    song = current_user.songs.find params[:song_id]

    compiler = SongdownCompiler.new(
      :input => song.content,
      :key => song.key
    )

    compiler.change_key params[:new_key]
    render :json => { :transposed_song => compiler.to_html }
  end
end
