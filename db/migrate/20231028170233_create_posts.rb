class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.belongs_to :user
      t.bigint :post_category_id

      t.timestamps
    end
  end
end
