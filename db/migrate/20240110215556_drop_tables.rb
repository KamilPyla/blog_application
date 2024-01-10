class DropTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :products
    drop_table :product_sub_categories
    drop_table :product_categories
  end
end
