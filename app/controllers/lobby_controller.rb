class LobbyController < ApplicationController

  before_filter :redirect_if_already_logged_in, :except => []

  def index
  end

  def register
    @user = User.new
  end
end
