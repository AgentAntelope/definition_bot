#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require './tweet'

# remove this to send out tweets
debug_mode

# remove this to update the db
no_update
# remove this to get less output when running
verbose

# here's a list of users to ignore
# blacklist "abc", "def"

# here's a list of things to exclude from searches
# exclude "hi", "spammer", "junk"

# search "keyword" do |tweet|
#  reply "Hey #USER# nice to meet you!", tweet
# end

# replies do |tweet|
#   reply "Yes #USER#, you are very kind to say that!", tweet
# end

while true
  tweet Tweet.new.message
  # sleep for, on average, half a day.
  sleep(rand(86400))
end
