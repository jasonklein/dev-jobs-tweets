class AddCompanyNameToMusings < ActiveRecord::Migration
  def change
    add_column :musings, :company_name, :string
  end
end
