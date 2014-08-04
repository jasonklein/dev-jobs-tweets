class Tweet < ActiveRecord::Base
  attr_accessible :text, :twitter_id, :tweeter, :tweeter_id, :by_friend, :twitter_created_at, :tweeter_avatar

  has_many :taggings, dependent: :destroy
  has_many :hashtags, through: :taggings

  mount_uploader :tweeter_avatar, TweeterAvatarUploader

  scope :by_friends, where(by_friend: true).order('twitter_created_at DESC')
  scope :by_strangers, where(by_friend: false).order('twitter_created_at DESC')

  def add_hashtags(hashtags_data)
    self.hashtags = []
    unhelpful_terms = ["job", "jobs", "getalljobs", "webdeveloper", "developer", "dev", "hiring", "it", "career", "careers", "jobs4u", "tweetmyjobs", "tech"]
    hashtags_data.each do |data_set|
      text = data_set["text"].downcase
      if !unhelpful_terms.include? text
        hashtag = Hashtag.where(text: text).first_or_create
        self.hashtags << hashtag
      end
    end
    self.hashtags = self.hashtags.uniq
  end

  def tweeter_handle
    "@#{self.tweeter}"
  end

  def tweeter_url
    "http://twitter.com/account/redirect_by_id?id=#{self.tweeter_id}"
  end


end
