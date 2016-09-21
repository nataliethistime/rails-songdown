class SetlistsController < ApplicationController

  before_filter :authenticate_user, :except => []
  before_filter :ensure_user_is_editor, :except => [:show]

  def add_items
    @setlist = Setlist.find params[:setlist_id]

    if @setlist
      @setlist_item = @setlist.setlist_items.new
    else
      # TODO
    end
  end

  def change_item_key
    @setlist = Setlist.find params[:setlist_id]

    if @setlist
      @setlist_item = @setlist.setlist_items.find params[:setlist_item_id]

      if @setlist_item
        @setlist_item.key = params[:key]
        @setlist_item.save
        redirect_to setlist_edit_items_path(:setlist_id => @setlist.id)
      else
        # TODO
      end
    else
      # TODO
    end
  end

  def create
    @setlist = @current_user.setlists.new setlist_params

    if @setlist.save
      flash[:success] = 'Successfully created setlist.'
      redirect_to @setlist
    else
      render 'new'
    end
  end

  def create_item
    @setlist = Setlist.find params[:setlist_id]

    if @setlist
      @setlist_item = @setlist.setlist_items.new setlist_item_params

      if @setlist_item.save
        flash[:success] = 'Successfully added song to setlist'
        redirect_to setlist_edit_items_path(:id => params[:setlist_id])
      else
        render 'add_items'
      end
    else
      # TODO
    end
  end

  def destroy
    @setlist = @current_user.setlists.find params[:id]
    @setlist.destroy

    redirect_to setlists_path
  end

  def destroy_item
    @setlist = Setlist.find params[:setlist_id]

    if @setlist
      @setlist_item = @setlist.setlist_items.find params[:id]
      @setlist_item.destroy

      redirect_to setlist_edit_items_path(@setlist)
    else
      # TODO
    end
  end

  def edit
    @setlist = @current_user.setlists.find params[:id]
  end

  def edit_items
    @setlist = @current_user.setlists.find params[:setlist_id]
    @setlist_items = @setlist.setlist_items.all.order(:position)
  end

  def index
    @upcoming_setlists = @current_user.setlists.where('setlists.date >= ?', Time.now)
    @past_setlists = @current_user.setlists.where('setlists.date < ?', Time.now)
  end

  def new
    @setlist = @current_user.setlists.new
  end

  def rearrange_items
    @setlist = @current_user.setlists.find params[:setlist_id]
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
    @setlist = Setlist.find params[:id]
    @setlist_items = @setlist.setlist_items.all.order(:position)
  end

  def update
    @setlist = @current_user.setlists.find params[:id]

    if @setlist.update setlist_params
      flash[:success] = 'Setlist updated.'
      redirect_to @setlist
    else
      render 'edit'
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
