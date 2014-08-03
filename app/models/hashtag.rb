class Hashtag < ActiveRecord::Base
  attr_accessible :text

  has_many :taggings, dependent: :destroy
  has_many :tweets, through: :taggings

end
