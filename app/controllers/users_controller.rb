class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @attendees=Attendee.all
    @hosting=current_user.events.to_a
    @events=Event.all
  end
end
