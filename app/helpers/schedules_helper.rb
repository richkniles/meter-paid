require 'twilio-ruby'

module SchedulesHelper
  
  AccountSid = 'AC7e13cf3807d51eb5eed7a28ee2eb450c'
  AuthToken = '07a35bf73fee891d8af303fc7ac17102'
  

  def call_meter_company(schedule)
    
    user = User.find(schedule.user_id)
    
    @client = Twilio::REST::Client.new AccountSid, AuthToken
    @account = @client.account

    @account.calls.create({
      :from => '+15106936860',#'+15109240329', #trial sandbox #
      :to => '+15106936860',
      :url => 'http://floating-wind-2082.herokuapp.com/twilio',
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
            credit_cv2 + 
            "wwwwwwwwwwwwwwwww"
            
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
