class Tagging < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :hashtag
  # attr_accessible :title, :body
end
