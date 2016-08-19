class SetlistsController < ApplicationController

  before_filter :authenticate_user, :except => []
  before_filter :ensure_user_is_editor, :except => []

  def create
    @setlist = Setlist.new setlist_params

    if @setlist.save
      flash[:success] = 'Successfully created setlist.'
      redirect_to @setlist
    else
      render 'new'
    end
  end

  def edit
    @setlist = Setlist.find params[:id]
  end

  def index
    @setlists = Setlist.all
  end

  def new
    @setlist = Setlist.new
  end

  def show
    @setlist = Setlist.find params[:id]
  end

  def update
    @setlist = Setlist.find params[:id]

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
        :artist,
        :key,
        :song_id,
        :title
      )
    end
end
