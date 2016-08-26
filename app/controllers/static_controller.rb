class StaticController < ApplicationController
  before_filter :authenticate_user, :except => []

  def about 
  end
end
