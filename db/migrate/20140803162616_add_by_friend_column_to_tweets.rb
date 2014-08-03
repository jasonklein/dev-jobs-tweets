class AddByFriendColumnToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :by_friend, :boolean, default: false
  end
end
