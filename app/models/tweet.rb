class Tweet < ActiveRecord::Base
  attr_accessible :text, :twitter_id, :tweeter, :tweeter_id, :by_friend, :twitter_created_at, :tweeter_avatar, :for_juniors

  has_many :taggings, dependent: :destroy
  has_many :hashtags, through: :taggings

  mount_uploader :tweeter_avatar, TweeterAvatarUploader

  default_scope order('twitter_created_at DESC')
  scope :by_friends, where(by_friend: true).order('twitter_created_at DESC')
  scope :by_strangers, where(by_friend: false).order('twitter_created_at DESC')


  def add_hashtags(hashtags_data)
    self.hashtags = []
    hashtags_data.each do |data_set|
      text = data_set["text"].downcase
      if hashtag_is_helpful?(text)
        hashtag = Hashtag.where(text: text).first_or_create
        self.hashtags << hashtag
      else
        return
      end
    end
    self.hashtags = self.hashtags.uniq
  end

  def tweeter_handle
    "@#{self.tweeter}"
  end

  def tweeter_url
    "https://twitter.com/#{self.tweeter}"
  end

  def hashtag_is_helpful?(text)
    unhelpful_terms = ["wrk", "hiring", "it", "tech", "oscarassociates", "roberthalf"]

    if unhelpful_terms.include? text
      false
    elsif text.include? "job"
      false
    elsif text.include? "work"
      false
    elsif text.include? "web"
      false
    elsif text.include? "dev"
      false
    elsif text.include? "career"
      false
    elsif text.include? "recruit"
      false
    else
      true
    end  
  end


end
