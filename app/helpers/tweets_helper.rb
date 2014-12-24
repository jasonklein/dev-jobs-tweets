module TweetsHelper
  def tweet_hex_main_class(tweet)
    text = tweet.text.downcase
    if text.include?("jr.") || text.include?("junior") || text.include?("interns")
      "junior"
    elsif tweet.twitter_created_at > 35.minutes.ago
      "new-tweet"
    else
      if tweet.by_friend == true
        "by-friend-" + ["1", "2", "3"].sample
      else
        "by-stranger-" + ["1", "2", "3"].sample
      end
    end
  end

  def tweet_hex_filter_classes(tweet, hashtags)
    text = tweet.text.downcase
    filter_classes = []

    hashtags.each do |hashtag|
      filter_classes << hashtag if text.include? "##{hashtag}"
    end

    filter_classes << "junior" if text.include?("jr.") || text.include?("junior") || text.include?("interns") || text.include?("entry-level") || text.include?("entry level")
    filter_classes << "new-tweet" if tweet.twitter_created_at > 35.minutes.ago
    filter_classes << (tweet.by_friend ? "followed" : "searched")
    filter_classes << "remote" if text.include? "remote"
    filter_classes = filter_classes.uniq
    filter_classes_string = filter_classes.join(" ")
    filter_classes_string
  end

end
