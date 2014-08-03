class Tagging < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :hashtag, counter_cache: true
  attr_accessible :tweet_id, :hashtag_id
end
