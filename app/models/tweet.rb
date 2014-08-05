class Tweet < ActiveRecord::Base
  attr_accessible :text, :twitter_id, :tweeter, :tweeter_id, :by_friend, :twitter_created_at, :tweeter_avatar

  has_many :taggings, dependent: :destroy
  has_many :hashtags, through: :taggings

  mount_uploader :tweeter_avatar, TweeterAvatarUploader

  default_scope order('twitter_created_at DESC')

  def add_hashtags(hashtags_data)
    self.hashtags = []
    unhelpful_terms = ["newjob", "job", "jobs", "work", "wrk", "getalljobs", "webdeveloper", "developer", "dev", "hiring", "it", "career", "careers", "jobs4u", "tweetmyjobs", "tech", "itjobs", "webdev", "oscarassociates"]
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
