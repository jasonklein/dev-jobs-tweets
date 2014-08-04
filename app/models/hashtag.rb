class Hashtag < ActiveRecord::Base
  attr_accessible :text

  has_many :taggings, dependent: :destroy
  has_many :tweets, through: :taggings

  default_scope order('taggings_count DESC')

end
