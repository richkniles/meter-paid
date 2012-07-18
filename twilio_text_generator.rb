#!/usr/bin/ruby

# erroring, probably since controller's headers aren't good for this

# input currently all nonsense unless labeled

meter_company_number = "18666497275" # correct

calling_from = "14155992671" # correct
pin_number = "1234" # i think
meter_location = "61215200" # @ sacramento & polk
minutes_to_add = "20" # needs to be variable
credit_cv2 = "750" # correct

ed = "*ww" + calling_from + "ww" + pin_number + "ww" + meter_location + "ww" + minutes_to_add + "ww" + credit_cv2 + "wwwwwwwwwwwwwwwww"

extensions_and_delays = ed
extensions_and_delays = "123wwww123"

generated_twiML = <<DONEHTML
<?xml version="1.0" encoding="UTF-8"?>
<Response>
    <Dial>
  <Number sendDigits=#{extensions_and_delays}>
  #{meter_company_number}
  </Number>
    </Dial>
</Response>
DONEHTML

puts generated_twiML
