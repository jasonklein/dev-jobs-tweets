class TweetsController < ApplicationController
  def index
    @friend_tweets = Tweet.by_friends
    @stranger_tweets = Tweet.by_strangers
  end
end





