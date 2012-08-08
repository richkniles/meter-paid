#!/usr/bin/ruby

require 'open-uri'
require 'twilio-ruby'

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!


$running = true
Signal.trap("TERM") do
  $running = false
end

while($running) do

  open("http://meter-paid.herokuapp.com/tickle")
  sleep 30

end

