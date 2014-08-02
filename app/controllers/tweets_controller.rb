class TweetsController < ApplicationController
  def index

    access_token = prepare_access_token
    home_timeline = get_dev_jobs_home_timeline(access_token)
    @tweets = home_timeline ? list_tweets(home_timeline) : ["There are no tweets"]
  end
end

def prepare_access_token
  consumer = OAuth::Consumer.new(ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'],
    { :site => "https://api.twitter.com",
      :scheme => :header
    })
  token_hash = {
    oauth_token: ENV['DEV_JOBS_ACCESS_TOKEN'], 
    oauth_token_secret: ENV['DEV_JOBS_ACCESS_TOKEN_SECRET']
  }
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  access_token
end

def get_dev_jobs_home_timeline(access_token)
  access_token = prepare_access_token
  response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")
  if response.code == "200"
    home_timeline = JSON.parse(response.body)
    home_timeline
  else
    return
  end
end

def list_tweets(home_timeline)
  tweets = []
  home_timeline.each do |tweet|
    tweets << tweet['text']
  end
  tweets
end








