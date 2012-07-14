### Call flow

Quotes = phone events

* Dial "18666497275" to initiate call
* "*" to opt into correct flow
* "phone number calling from"
* "PIN #"
* "8-digit meter location"
* "# of minutes to add"
* "last 3 digits from credit card signiture line"
* "~10 second pause"
* Success, "phone hangs up"

### Test Meters
* Meter number 61215200 (near Sac/Polk)

### Resources

* Twilio docs: https://github.com/twilio/twilio-ruby#readme

* <Dial/number> may be the TwiML that I need: https://www.twilio.com/docs/api/twiml/number

* Upgrading account is very cheap, since pricing totally variable

### To do - major
* Separate out all personal details, put into personalSettings, gitignore it so that personal details aren't spread around
* Ideally, have it call you if the transaction fails (i.e. no receipt received from it)
  * Hypothesis - it won't hang up on you without success. Test this.
* How test? Need to collude with a parking official, or see if the meter can give status update instead of a straight top-up

### To do - minor
* Make it pretty
* Legally, one can't pay another's meter, so need a disclaimer if go public
* Recommend pay-by-phone sticker to users?
