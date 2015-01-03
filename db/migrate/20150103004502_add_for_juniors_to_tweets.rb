class AddForJuniorsToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :for_juniors, :boolean, default: false
  end
end
