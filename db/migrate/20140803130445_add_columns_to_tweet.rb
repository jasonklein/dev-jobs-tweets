class AddColumnsToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :twitter_created_at, :datetime
    add_column :tweets, :tweeter_avatar, :string
  end
end
