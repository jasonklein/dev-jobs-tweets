class Tweet < ActiveRecord::Base
  attr_accessible :text, :twitter_id, :tweeter, :tweeter_id, :by_friend, :twitter_created_at

  has_many :taggings, dependent: :destroy
  has_many :hashtags, through: :taggings

  def add_hashtags(hashtags_data)
    self.hashtags = []
    hashtags_data.each do |data_set|
      text = data_set["text"]
      hashtag = Hashtag.where(text: text).first_or_create
      self.hashtags << hashtag
    end
    self.hashtags = self.hashtags.uniq
  end


end
