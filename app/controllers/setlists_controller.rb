class SetlistsController < ApplicationController

  before_filter :authenticate_user, :except => []
  before_filter :ensure_user_is_editor, :except => [:show]

  def create
    @setlist = @current_user.setlists.new setlist_params

    if @setlist.save
      flash[:success] = 'Successfully created setlist.'
      redirect_to @setlist
    else
      render 'new'
    end
  end

  def destroy
    @setlist = @current_user.setlists.find params[:id]
    @setlist.destroy

    redirect_to setlists_path
  end

  def edit
    @setlist = @current_user.setlists.find params[:id]
  end

  def index
    @upcoming_setlists = @current_user.setlists.where('setlists.date >= ?', Time.now)
    @past_setlists = @current_user.setlists.where('setlists.date < ?', Time.now)
  end

  def new
    @setlist = @current_user.setlists.new
  end

  def show
    @setlist = Setlist.find params[:id]
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
end
