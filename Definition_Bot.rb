#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require './tweet'

# remove this to send out tweets
# debug_mode

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

threads = []

threads << Thread.new { replying_to_requests }

threads << Thread.new { standard_tweeting }

def replying_to_requests
  while true
    replies do |tweet|
      match = tweet[:text].match(/please define (\w+)/)
      if match
        reply ("#USER# " + Tweet.new(match.captures.first).message)
      end
    end
    sleep(300)
    # only reply once every 5 minutes.
  end
end

def standard_tweeting
  while true
    sleep(rand(86400))
    tweet Tweet.new.message
    # sleep for, on average, half a day.
  end
end

threads.each(&:join)
