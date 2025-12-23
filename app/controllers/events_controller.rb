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
    @invitations=Invitation.all
  end

  def show
    @attendees=Attendee.all
    @event=Event.find(params[:id])
    @invitations=Invitation.all
    @users=User.all
  end

  def change_invite
    @event=Event.find(params[:id])
    @invitations=Invitation.all
    user_id=params[:user_id].to_i
    invite=Invitation.find_by(
      user_id: user_id,
      event_id: @event.id
    )
    if invite
      invite.destroy
      attendee=Attendee.find_by(
        user_id: user_id,
        event_id: @event.id
      )
      if attendee
        attendee.destroy
      end
    else
      Invitation.create(event: @event, user_id: user_id)
    end

    redirect_to @event
  end

  def change_access
    @event=Event.find(params[:id])
    @event.private=!@event.private
    @event.save
    redirect_to events_path
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

  def destroy
    @event=Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:description, :title)
  end
end
