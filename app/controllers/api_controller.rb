class ApiController < ApplicationController
  def search_songs
    if params[:query].instance_of? String
      params[:query].strip!
    end
    
    @results = Song.search(params[:query])
    render :json => @results
  end
end
