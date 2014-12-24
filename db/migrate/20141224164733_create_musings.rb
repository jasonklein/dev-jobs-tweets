class CreateMusings < ActiveRecord::Migration
  def change
    create_table :musings do |t|
      t.string :muse_id
      t.string :title
      t.string :apply_link
      t.string :company_logo
      t.datetime :muse_created_at

      t.timestamps
    end
  end
end
