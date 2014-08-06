require_relative '../twitter_api_helper'
include TwitterApiHelper

namespace :tweets do
  desc "Get tweets from home timeline and searching."
  task :get => :environment do
    get_and_save_tweets
  end

  desc "Destroy old tweets from friends."
  task :destroy_friend_tweets => :environment do
    tweets = Tweet.where(["by_friend = ? and twitter_created_at < ?", true, 1.month.ago])
    tweets.each do |tweet|
      tweet.destroy
    end
  end

  desc "Destroy old tweets from strangers."
  task :destroy_stranger_tweets => :environment do
    tweets = Tweet.where(["by_friend = ? and twitter_created_at < ?", false, 2.days.ago])
    tweets.each do |tweet|
      tweet.destroy
    end
  end
end