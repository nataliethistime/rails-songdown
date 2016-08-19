class ApiController < ApplicationController
  def search_songs
    @results = Song.search(params[:query])

    if params[:raw]
      render :json => @results
    else
      #
    end
  end
end
