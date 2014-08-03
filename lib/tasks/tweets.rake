require_relative '../twitter_api_helper'
include TwitterApiHelper

namespace :tweets do
  desc "Get tweets from home timeline and searching."
  task :get => :environment do

    get_and_save_tweets
  end
end