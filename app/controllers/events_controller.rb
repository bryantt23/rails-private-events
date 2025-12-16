class EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event=Event.new
  end

  def index
    @attendees=Attendee.all
    @events=Event.all
  end

  def show
    @event=Event.find(params[:id])
  end

  def create
    @event=current_user.events.build(event_params)

    if @event.save
      redirect_to users_show_path
      # redirect_to @event
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :title)
  end
end
