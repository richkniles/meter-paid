require 'twilio-ruby'

module SchedulesHelper
  
  AccountSid = 'AC019c83da8ef75c162b430e909464f5a4' #MDP account
  AuthToken = '21b3ac20f26865a84b05b9c8d7f54283'
  

  def call_meter_company(schedule)
    
    user = User.find(schedule.user_id)
    
    @client = Twilio::REST::Client.new AccountSid, AuthToken
    @account = @client.account

    @account.calls.create({
      :from => '+14152382438', #MDP account
      :to => '+15106936860',
      :url => 'http://meter-paid.herokuapp.com/twilio',
      :SendDigits => "#{format_extensions_and_delays(schedule, user)}"
    })
    
  end
  
  def format_extensions_and_delays(schedule, user)
    calling_from = user.phone.split("-").join
    pin_number = user.meter_company_account_pin
    credit_cv2 = user.cv2
    
    meter_location = schedule.meter
    minutes_to_add = schedule.minutes_to_add
    
    ed = "*ww" +
            calling_from +
            "ww" + 
            pin_number + 
            "ww" + 
            meter_location + 
            "ww" + 
            minutes_to_add.to_s + 
            "ww" + 
            credit_cv2            
  end
  
  def twilio_ml(schedule_id)
    schedule = Schedule.find(schedule_id)
    user = User.find(schedule.user_id)

    extensions_and_delays = format_extensions_and_delays(schedule, user)

    meter_company_number = "15106936860"

    generated_twiML = 
  <<-TWILIO_ML
  <?xml version="1.0" encoding="UTF-8"?>
  <Response>
      <Dial>
    <Number sendDigits="#{extensions_and_delays}">
    #{meter_company_number}
    </Number>
      </Dial>
  </Response>
  TWILIO_ML

  end
 
end
