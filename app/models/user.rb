class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, 
                  :phone, :meter_company_account_pin, :cv2, :remember_token
                  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true, length: {minimum: 6}
  
  before_save :create_remember_token
  
  has_many :schedules
  
  def upcoming_schedules
    self.schedules.where("time > ?", Time.zone.now)
  end
  
  private
  
    def create_remember_token
      self.remember_token ||= SecureRandom.urlsafe_base64
    end
end
