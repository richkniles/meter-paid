class Schedule < ActiveRecord::Base
  attr_accessible :amount, :meter, :time
  
  monetize :amount_cents
  
  validates :amount, numericality: { greater_than: 0 }
  validates :meter, presence: true
  validate :at_least_5_min_from_now
  
  belongs_to :user
  
  default_scope order: "schedules.time"
  
  private
  
    def at_least_5_min_from_now
      unless time > 5.minutes.from_now
        errors.add(:time, "Must be later than 5 minutes from now")
      end
    end
      
  
end
