class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @events=current_user.events.to_a
  end
end
