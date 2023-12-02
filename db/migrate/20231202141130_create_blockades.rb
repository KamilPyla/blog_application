class CreateBlockades < ActiveRecord::Migration[7.1]
  def change
    create_table :blockades do |t|
      t.integer :blocker_id, null: false, index: true
      t.integer :blocked_id, null: false, index: true

      t.timestamps
    end
  end
end
