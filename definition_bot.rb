#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require './tweet'
require 'date'

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

STARTUP_TIME = DateTime.now

threads = []

threads << Thread.new { replying_to_requests }

threads << Thread.new { standard_tweeting }

def replying_to_requests
  while true
    # only reply once every 5 minutes.
    sleep(300)

    replies do |tweet|
      # Possible calls:
      # define #{word}
      match = tweet[:text].match(/(?:define) (\w+)/i)
      if match && STARTUP_TIME < DateTime.parse(tweet[:created_at])
        reply ("#USER# " + Tweet.new(match.captures.last).message), tweet

        # To avoid tweeting too often
        sleep(10)
      end      
    end
    update_config
  end
end

def standard_tweeting
  while true
    # sleep for, on average, half a day.
    sleep(rand(86400))

    tweet Tweet.new.message
  end
end

threads.each(&:join)
