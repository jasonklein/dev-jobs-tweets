class AddColumnToMusings < ActiveRecord::Migration
  def change
    add_column :musings, :for_juniors, :boolean, default: false
  end
end
