class TweetsController < ApplicationController
  def index
    @tweets = Tweet.limit(500)
    @hashtags = Hashtag.limit(10)
  end
end





