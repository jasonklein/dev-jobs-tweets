class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    @hashtags = Hashtag.limit(10)
  end
end





