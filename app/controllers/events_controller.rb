class EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event=Event.new
  end

  def index
  end

  def create
    @event=current_user.events.build(event_params)
    puts "hiii"

    if @event.save
      redirect_to users_show_path
      # redirect_to @event
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:description)
  end
end
