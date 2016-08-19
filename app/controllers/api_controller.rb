class ApiController < ApplicationController
  def search_songs
    @results = Song.search(params[:query])
    render :json => @results
  end
end
