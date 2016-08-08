class LobbyController < ApplicationController

  before_filter :redirect_if_already_logged_in, :except => []

  def about
  end

  def index
  end
end
