class TweetsController < ApplicationController
  def index
    @tweets = Tweet.limit(00)
    @hashtags = Hashtag.limit(10)
  end
end





