class LobbyController < ApplicationController

  before_filter :redirect_if_already_logged_in, :except => []

  def index
    render :layout => 'logged_out'
  end

  def register
    @user = User.new
    render :layout =>'logged_out'
  end
end
