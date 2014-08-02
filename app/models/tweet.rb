class Tweet < ActiveRecord::Base
  attr_accessible :text, :tweet_id, :tweeter
end
