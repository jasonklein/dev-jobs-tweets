module TwitterApiHelper
  def oauth_consumer
    OAuth::Consumer.new(ENV["TWITTER_API_KEY"], ENV["TWITTER_API_SECRET"],
      { :site => "https://api.twitter.com",
        :scheme => :header
      })
  end

  def oauth_access_token
    token_hash = {
      oauth_token: ENV["TWITTER_ACCESS_TOKEN"], 
      oauth_token_secret: ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    }
    OAuth::AccessToken.from_hash(oauth_consumer, token_hash)
  end

  def twitter_api_home_timeline_url
    "https://api.twitter.com/1.1/statuses/home_timeline.json?count=200&exclude_replies=true"
  end

  def twitter_api_search_url(term_1, term_2)
    date = Date.today.strftime("%Y-%m-%d")
    "https://api.twitter.com/1.1/search/tweets.json?q=#{term_1}%20#{term_2}%20since%3A#{date}&src=typd&result_type=recent&count=100"
  end

  def twitter_api_friends_url
    "https://api.twitter.com/1.1/friends/ids.json?user_id=#{ENV['TWITTER_ACCOUNT_ID']}"
  end

  ### For home timeline, requester is the oauth_access_token
  ### For search, requester is the oauth_consumer

  def get_dev_jobs_tweets_array(requester, url, provenance="")
    response = requester.request(:get, url)
    if response.code == "200"
      if provenance == "home"
        tweets_array = JSON.parse(response.body)
      else
        search_results = JSON.parse(response.body)
        tweets_array = search_results["statuses"]
      end
      tweets_array
    else
      return
    end
  end

  def home_timeline_data
    tweets = get_dev_jobs_tweets_array(oauth_access_token, twitter_api_home_timeline_url, "home")
    provenance = "home"
    { twitter_response: tweets || [], provenance: "home" }
  end

  def searches_data
    search_url_term_pairs = [["ruby", "developer"],["web","developer"],["junior","developer"],["web","designer"]]
    tweets = []

    search_url_term_pairs.each do |pair|
      term_1 = pair[0]
      term_2 = pair[1]
      search_url = twitter_api_search_url(term_1, term_2)
      tweets += get_dev_jobs_tweets_array(oauth_consumer, search_url)
    end
    { twitter_response: tweets || [], provenance: "search" }
  end

  def twitter_friends_ids
    response = oauth_consumer.request(:get, twitter_api_friends_url)
    if response.code == "200"
      friends_data = JSON.parse(response.body)
      friends_data["ids"]
    else
      return
    end
  end

  def attribute_for_tweet_by_friend(friends_ids, tweeter_id)
    friends_ids.include? tweeter_id ? true : false
  end

  def save_tweets(data)
    tweets = data[:twitter_response]
    provenance = data[:provenance]

    if provenance == "search"
      friends_ids = twitter_friends_ids
    end

    tweets.each do |tweet|
      text = tweet["text"]
      if tweet_seems_relevant(text, provenance)
        hashtags_data = tweet["entities"]["hashtags"]
        tweeter_id = tweet["user"]["id_str"]
        Tweet.where(twitter_id: tweet["id_str"]).first_or_create do |t|
          t.text = text
          t.tweeter = tweet["user"]["screen_name"]
          t.tweeter_id = tweeter_id
          t.tweeter_avatar = tweet["user"]["profile_image_url"]
          t.twitter_created_at = tweet["created_at"]
          t.by_friend = friends_ids ? attribute_for_tweet_by_friend(friends_ids, tweeter_id) : true
          t.add_hashtags(hashtags_data)
        end
      end
    end
  end

  def tweet_seems_relevant(text, provenance)
    text = text.downcase
    relevance_count = 0
    search_filter_terms = ["job", "vacancy", "position", "opening"]

    if provenance == "search"
      search_filter_terms.each do |term|
        relevance_count += 1 if text.include?(term)
      end
      if relevance_count > 0
        true
      else
        false
      end
    else
      home_filter_terms = search_filter_terms + ["jr", "web", "dev", "engineer", "ruby", "rails"]
      home_filter_terms.each do |term|
        relevance_count += 1 if text.include?(term)
      end
      if relevance_count >= 2
        true
      else
        false
      end
    end 
  end

  def get_and_save_tweets
    save_tweets(home_timeline_data)
    save_tweets(searches_data)
  end

end