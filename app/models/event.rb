class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :attendees, through: :attendees

  def self.future(attendees, events, current_user)
    attended_events = attendees.filter { |a| a.user_id==current_user.id }
    future_events=attended_events.filter { |event|
      events.find { |e| e.id == event.event_id }.date >= Date.today
    }
  end

  def self.past(attendees, events, current_user)
    attended_events = attendees.filter { |a| a.user_id==current_user.id }
    future_events=attended_events.filter { |event|
      events.find { |e| e.id == event.event_id }.date < Date.today
    }
  end
end
