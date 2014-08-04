class TweetsController < ApplicationController
  def index
    @tweets = Tweet.limit(300)
    @hashtags = Hashtag.limit(10)
  end
end





