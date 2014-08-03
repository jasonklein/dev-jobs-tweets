class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tweet
      t.references :hashtag

      t.timestamps
    end
    add_index :taggings, :tweet_id
    add_index :taggings, :hashtag_id
  end
end
