class TweetsController < ApplicationController
  def index
    @tweets = Tweet.limit(100)
    @hashtags = Hashtag.limit(10)
  end
end





