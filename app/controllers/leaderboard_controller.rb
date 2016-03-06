class LeaderboardController < ApplicationController
  def index
    @users = User.all.order(points: :desc).limit(20)
  end
end
