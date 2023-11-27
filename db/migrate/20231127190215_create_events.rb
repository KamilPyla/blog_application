class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :city, null: false
      t.string :street
      t.date :date
      t.datetime :start_at
      t.integer :max_tickets
      t.integer :price
      t.integer :total_tickets

      t.timestamps
    end
  end
end
