class SetlistItemsController < ApplicationController

  before_filter :authenticate_user, :except => []
  before_filter :ensure_user_is_editor, :except => []

  def create
    @setlist = Setlist.find params[:setlist_id]

    if @setlist
      @setlist_item = @setlist.setlist_items.new setlist_item_params

      if @setlist_item.save
        flash[:success] = 'Successfully added song to setlist'
        redirect_to :controller => 'setlists', :action => 'show', :id => params[:setlist_id]
      else
        render 'new'
      end
    else
      # TODO
    end
  end

  def destroy
    @setlist = Setlist.find params[:setlist_id]

    if @setlist
      @setlist_item = @setlist.setlist_items.find params[:id]
      @setlist_item.destroy

      redirect_to @setlist
    else
      # TODO
    end
  end

  def new
    @setlist = Setlist.find params[:setlist_id]

    if @setlist
      @setlist_item = @setlist.setlist_items.new
    else
      # TODO
    end
  end

  def setlist_item_params
    params.require(:setlist_item).permit(
      :title,
      :date,
      :notes,
      :key,
      :song_id,
      :artist
    )
  end
end
