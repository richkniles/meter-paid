module SchedulesHelper
  
  def test_twilio_ml(x)
    
    generated_twiML = 
    <<-TWILIO_ML
    <?xml version='1.0' encoding='utf-8' ?>
    <Response>
    	<Say>Thanks for the call. Configure your number's voice U R L to change this message.</Say>
    	<Pause length="1"/>
    	<Say voice='woman'>Let us know if we can help you in any way during your development.</Say>
    </Response>
    TWILIO_ML
  end

  def twilio_ml(schedule_id)
    schedule = Schedule.find(schedule_id)
    user = User.find(schedule.user_id)
    
    extensions_and_delays = format_extensions_and_delays(schedule, user)
    
    meter_company_number = "15106936860"
    
    generated_twiML = <<-TWILIO_ML
    <?xml version="1.0" encoding="UTF-8"?>
    <Response>
        <Dial>
      <Number sendDigits=#{extensions_and_delays}>
      #{meter_company_number}
      </Number>
        </Dial>
    </Response>
    TWILIO_ML

  end
  
  def format_extensions_and_delays(schedule, user)
    calling_from = user.phone
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
  
end
