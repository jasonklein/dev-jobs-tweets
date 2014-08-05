class TweetsController < ApplicationController
  def index
    @tweets = Tweet.limit(100)
    @hashtags = get_hashtags_for_limited_tweets(@tweets)

  end
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





