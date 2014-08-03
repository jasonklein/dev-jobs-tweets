class AddTweeterIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweeter_id, :string
  end
end
