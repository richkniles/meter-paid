class Schedule < ActiveRecord::Base
  attr_accessible :minutes_to_add, :meter, :time
  
  
  validates :minutes_to_add, numericality: { greater_than: 0 }
  validates :meter, presence: true
  validate :at_least_1_min_from_now
  
  before_save :set_status_to_pending
  
  belongs_to :user
  
  default_scope order: "schedules.time"
  
  #status:
  PENDING = 1
  COMPLETED_SUCCESSFULLY = 2
  COMPLETED_WITH_ERROR = 3
  
  private
  
    def at_least_1_min_from_now
      unless time > 1.minutes.from_now
        errors.add(:time, "Must be later than 5 minutes from now")
      end
    end
      
    def set_status_to_pending
      self.status ||= PENDING
    end
  
end
