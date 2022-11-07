class LandingsController < ApplicationController
  def index
    @user = Current.user
  end
end
