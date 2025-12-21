class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @attendees=Attendee.all
    @hosting=current_user.events.to_a
    @events=Event.all
    @future_events=Event.future(current_user)
    @past_events=Event.past(current_user)
  end
end
