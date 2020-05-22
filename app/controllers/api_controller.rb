require 'songdown_compiler'

class ApiController < ApplicationController
  def compile_songdown
    compiler = SongdownCompiler.new(
      :input => params[:input],
      :show_key => false
    )

    render :json => {
      :output => compiler.to_html
    }
  end

  def transpose_song
    song = Song.find params[:song_id]

    if !song.nil?
      compiler = SongdownCompiler.new(
        :input => song.content,
        :key => song.key
      )

      compiler.change_key params[:new_key]

      render :json => {
        :transposed_song => compiler.to_html
      }
    else
      # TODO
    end
  end
end
