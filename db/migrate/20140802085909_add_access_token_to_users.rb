class AddAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accesstoken, :string
  end
end
