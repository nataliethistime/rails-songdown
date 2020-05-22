class SetlistsController < ApplicationController
  def change_item_key
    @setlist = Setlist.find params[:setlist_id]
    @setlist_item = @setlist.setlist_items.find params[:setlist_item_id]

    @setlist_item.key = params[:key]
    @setlist_item.save
    redirect_to setlist_edit_items_path(:setlist_id => @setlist.id)
  end

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

  def destroy_item
    @setlist = current_user.setlists.find params[:setlist_id]
    @setlist_item = @setlist.setlist_items.find params[:id]
    @setlist_item.destroy
    redirect_to @setlist
  end

  def edit
    @setlist = current_user.setlists.find params[:id]
  end

  def edit_items
    @setlist = current_user.setlists.find params[:setlist_id]
    @setlist_items = @setlist.setlist_items.all.order(:position)
  end

  def index
    @setlists = current_user.setlists.all
  end

  def new
    @setlist = current_user.setlists.new
  end

  def rearrange_items
    @setlist = current_user.setlists.find params[:setlist_id]
    updates = {}

    params[:items].each do |item|
      updates[item[:id]] = {
        :position => item[:position]
      }
    end

    ActiveRecord::Base.transaction do
      @setlist.setlist_items.update(updates.keys, updates.values)
    end

    redirect_to setlist_edit_items_path(:setlist_id => params[:setlist_id])
  end

  def show
    @setlist = current_user.setlists.find params[:id]
    @setlist_items = @setlist.setlist_items.all.order(:position)
  end

  def update
    @setlist = current_user.setlists.find params[:id]

    if @setlist.update setlist_params
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

    # TODO: do this better
    @setlist_item = @setlist.setlist_items.new(
      song_id: @song.id,
      artist: @song.artist,
      title: @song.title,
      key: @song.key,
      position: @setlist.setlist_items.count
    )

    if @setlist_item.save
      flash[:notice] = 'Successfully added song to setlist'
      redirect_to @setlist
    else
      render 'add_items'
    end
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
