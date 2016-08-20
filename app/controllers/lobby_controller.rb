class LobbyController < ApplicationController

  before_filter :redirect_if_already_logged_in, :except => []

  def about
    render :layout => 'logged_out'
  end

  def index
    render :layout => 'logged_out'
  end
end
