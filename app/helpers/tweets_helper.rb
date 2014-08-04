module TweetsHelper
  def tweet_hex_class(tweet)
    text = tweet.text.downcase
    if text.include?("jr.") || text.include?("junior")
      "junior"
    elsif tweet.twitter_created_at > 2.hours.ago
      "new-tweet"
    else
      if tweet.by_friend == true
        "by-friend-" + ["1", "2", "3"].sample
      else
        "by-stranger-" + ["1", "2", "3"].sample
      end
    end
  end
end
