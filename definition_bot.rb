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

STARTUP_TIME = Time.now

threads = []

def replying_to_requests
  replied_to_tweet_ids = []
  while true

    replies do |tweet|
      # Possible calls:
      # define #{word}
      initial_match = tweet.text.match(/(?:define) (\w*-?\w*)/i)

      if initial_match
        match = initial_match.captures.first.match(/(\w.*\w)/)
      end

      if initial_match && STARTUP_TIME < tweet[:created_at] && !replied_to_tweet_ids.include?(tweet[:id])

        sleep(30)
        if match && !(match.captures.nil? || match.captures.empty?)
          reply ("#USER# " + Tweet.new(match.captures.first).message), tweet
        else
          reply ("#USER# I'm sorry, I don't know what you're asking me to define!"), tweet
        end
        replied_to_tweet_ids << tweet[:id]
      end

      sleep(30)
    end

    # To avoid tweeting too often
    sleep(60)

    update_config
  end
end

def standard_tweeting
  while true
    tweet Tweet.new.message

    # sleep for, on average, half a day.
    sleep(rand(86400))
  end
end

threads << Thread.new { replying_to_requests }

threads << Thread.new { standard_tweeting }

threads.each(&:join)
