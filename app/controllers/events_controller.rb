class EventsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @event=Event.find(params[:id])
  end

  def update
    @event=Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @event=Event.new
  end

  def index
    @attendees=Attendee.all
    @events=Event.all
  end

  def show
    @attendees=Attendee.all
    @event=Event.find(params[:id])
  end

  def change_status
    @attendees=Attendee.all
    @event=Event.find(params[:id])
    attending=@attendees.find { |a| @event.id==a.event_id && a.user_id==current_user.id }
    if attending
      Attendee.delete(attending.id)
    else
      Attendee.create({ user_id: current_user.id, event_id: params[:id] })
    end
    redirect_to @event
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
