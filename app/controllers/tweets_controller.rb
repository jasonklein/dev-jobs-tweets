class TweetsController < ApplicationController
  def index

     

  end
end

def prepare_access_token
  consumer = OAuth::Consumer.new(ENV['TWITTER_API_KEY', ENV['TWITTER_API_SECRET'],
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
    home_timeline_hash = JSON.parse(response.body)
    home_timeline_hash
  else
    return
  end
end

def search_and_save_tweets(home_timeline)