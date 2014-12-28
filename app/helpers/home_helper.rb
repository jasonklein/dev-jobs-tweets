module HomeHelper

  def haml_for_post(post)
    if post.is_a? Tweet
      if params[:action] == "index"
        render partial: "index_tweet", locals: {tweet: post}
      else
        render partial: "archive_tweet", locals: {tweet: post}
      end
    else
      if params[:action] == "index"
        render partial: "index_musing", locals: {musing: post}
      else
        render partial: "archive_musing", locals: {musing: post}     
      end   
    end
  end

  def post_listing_classes(post)
    classes = []
    if post.is_a? Musing
      classes << "musing"
      classes << "archive-junior"
    else
      classes << "tweet"
      classes << archive_tweet_main_class(post)
    end
    classes.join(" ")
  end

  def archive_tweet_main_class(tweet)
    text = tweet.text.downcase
    if text_has_junior_terms? text
      "archive-junior"
    else
      if tweet.by_friend == true
        "archive-by-friend-" + ["1", "2", "3"].sample
      else
        "archive-by-stranger-" + ["1", "2", "3"].sample
      end
    end
  end

end