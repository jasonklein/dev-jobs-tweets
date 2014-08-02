class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.string :text
      t.string :tweeter

      t.timestamps
    end
  end
end
