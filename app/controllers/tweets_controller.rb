class TweetsController < ApplicationController
  def index
    consumer = oauth_consumer
    access_token = oauth_access_token(consumer)
    home_timeline = get_dev_jobs_home_timeline(access_token)
    @tweets = home_timeline ? list_tweets(home_timeline) : ["There are no tweets"]
  end
end

def oauth_consumer
  consumer = OAuth::Consumer.new(ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'],
    { :site => "https://api.twitter.com",
      :scheme => :header
    })
  consumer
end

def oauth_access_token(consumer)
  token_hash = {
    oauth_token: ENV['TWITTER_ACCESS_TOKEN'], 
    oauth_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
  }
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  access_token
end

def get_dev_jobs_home_timeline(access_token)
  response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json?count=200")
  if response.code == "200"
    home_timeline = JSON.parse(response.body)
    home_timeline
  else
    return
  end
end

def list_tweets(home_timeline)
  tweets = []
  search_terms = ['jr', 'web', 'dev', 'engineer', 'ruby', 'rails']
  home_timeline.each do |tweet|
    text = tweet['text'].downcase
    result = 0
    search_terms.each do |term|
      result += 1 if text.include?(term)
    end
    tweets << tweet['text'] if result >= 2
  end
  tweets
end





