class Tweet < ActiveRecord::Base
  attr_accessible :text, :tweet_id, :tweeter

  has_many :taggings, dependent: :destroy
  has_many :hashtags, through: :taggings
end
