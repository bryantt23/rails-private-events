class Event < ApplicationRecord  
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  has_many :attendees
  has_many :users, through: :attendees
  
  scope :future, ->(current_user) {
    joins(:attendees).where("attendees.user_id = ?", current_user.id).where("events.date >= ?", Date.today)  
  }

  scope :past, ->(current_user) {
    joins(:attendees).where("attendees.user_id = ?", current_user.id).where("events.date < ?", Date.today)
  }
end
