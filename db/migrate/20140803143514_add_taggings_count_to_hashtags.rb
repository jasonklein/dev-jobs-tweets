class AddTaggingsCountToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :taggings_count, :integer
  end
end
