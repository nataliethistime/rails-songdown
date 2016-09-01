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

  def search_songs
    if params[:query].instance_of? String
      params[:query].strip!
    end

    @results = Song.search(params[:query])
    render :json => @results
  end
end
