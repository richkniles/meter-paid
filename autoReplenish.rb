#!/usr/bin/ruby

# Goal: replenish parking meter by a given amount of time, at a given time

# Command line arguments:
# 0: what parking meter to replenish
# 1: how many minutes to replenish for

#require 'rubygems'
require 'twilio-ruby'

account_sid = 'AC019c83da8ef75c162b430e909464f5a4'
auth_token = '21b3ac20f26865a84b05b9c8d7f54283'

@client = Twilio::REST::Client.new account_sid, auth_token
@account = @client.account

=begin
#working way to send a text message
@client.account.sms.messages.create(
                                    :from => '+14155992671', # trial #
                                    :to => '+14152382438',
                                    :body => 'test text!'
)
=end

#note: need a call handler URL as requirement of making the call
@account.calls.create({
  :from => '+14155992671', #trial sandbox #
  :to => '+14152382438',
  :url => 'http://MeterPaid.twilio.com/welcome/voice/' #this needs to have the logic of dialing more numbers
})
