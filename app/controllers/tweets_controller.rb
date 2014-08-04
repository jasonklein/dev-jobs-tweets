class TweetsController < ApplicationController
  def index
    @friends_tweets = Tweet.by_friends
    @strangers_tweets = Tweet.by_strangers
  end
end





