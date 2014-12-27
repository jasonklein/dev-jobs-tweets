class TweetsController < ApplicationController
  def index

    ### Split, combine and sort tweets to favor tweets from "friends"
    ### over tweets from searching

    friends_tweets = Tweet.by_friends.limit(200)
    stranger_tweets_limit = 300 - friends_tweets.count
    stranger_tweets = Tweet.by_strangers.limit(stranger_tweets_limit)
    unsorted_tweets = friends_tweets + stranger_tweets

    @hashtags = get_hashtags_for_limited_tweets(unsorted_tweets)

    musings = Musing.all
    unsorted_posts = unsorted_tweets + musings
    sorted_posts = unsorted_posts.sort_by do |post|
      if post.is_a? Tweet
        post.twitter_created_at
      else
        post.muse_created_at
      end
    end
    @posts = sorted_posts.reverse  
  end

  def get_hashtags_for_limited_tweets(tweets)
    hashtags_hash = Hash.new(0)
    hashtags = []
    tweets.each do |tweet|
      if tweet.hashtags.any?
        tweet.hashtags.each do |hashtag|
          hashtags_hash[hashtag.text] += 1
        end
      end
    end
    sorted_hashtags_and_counts = hashtags_hash.sort_by {|text,count| count}
    sorted_hashtags_and_counts.reverse!
    if sorted_hashtags_and_counts.length > 10
      sorted_hashtags_and_counts[0..9].each do |text_count|
        hashtags << text_count[0]
      end
    else
      sorted_hashtags_and_counts.each do |text_count|
        hashtags << text_count[0]
      end
    end
    hashtags
  end

end
