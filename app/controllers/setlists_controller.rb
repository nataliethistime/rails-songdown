class SetlistsController < ApplicationController
  def create
    @setlist = current_user.setlists.new setlist_params

    if @setlist.save
      flash[:notice] = 'Successfully created setlist.'
      redirect_to @setlist
    else
      render 'new'
    end
  end

  def destroy
    @setlist = current_user.setlists.find params[:id]
    @setlist.destroy

    redirect_to setlists_path
  end

  def edit
    @setlist = current_user.setlists.find params[:id]
  end

  def index
    @setlists = current_user.setlists.all
  end

  def new
    @setlist = current_user.setlists.new
  end

  def show
    @setlist = current_user.setlists.find params[:id]
    @setlist_items = @setlist.setlist_items.all.order(:position)
  end

  def update
    @setlist = current_user.setlists.find params[:id]
    @setlist.update setlist_params

    if @setlist.save
      flash[:notice] = 'Setlist updated.'
      redirect_to @setlist
    else
      render 'edit'
    end
  end

  def search_songs
    if params[:query].instance_of? String
      params[:query].strip!
    end

    @setlist = current_user.setlists.find params[:setlist_id]
    @results = Song.search(params[:query]).order(:artist)

    respond_to do |format|
      format.js
    end
  end

  def add_song
    @setlist = current_user.setlists.find params[:setlist_id]
    @song = Song.find params[:song_id]

    @setlist_item = @setlist.setlist_items.new key: @song.key
    @setlist_item.song = @song
    @setlist_item.save!

    flash[:notice] = 'Successfully added song to setlist'
    redirect_to @setlist
  end

  def update_song
    @setlist = current_user.setlists.find params[:setlist_id]
    @setlist_item = @setlist.items.find params[:song_id]

    @setlist_item.key = params[:key]
    @setlist_item.save!
    redirect_to @setlist
  end

  def destroy_song
    @setlist = current_user.setlists.find params[:setlist_id]
    @setlist_item = @setlist.setlist_items.find params[:id]
    @setlist_item.destroy
    redirect_to @setlist
  end

  private

  def setlist_params
    params.require(:setlist).permit(
      :title,
      :date,
      :notes
    )
  end
end
