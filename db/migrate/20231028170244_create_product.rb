class CreateProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.belongs_to :user

      t.string :name
      t.integer :price_in_cents
      t.bigint :product_category_id

      t.timestamps
    end
  end
end
