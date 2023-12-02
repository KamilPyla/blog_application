class CreateObservations < ActiveRecord::Migration[7.1]
  def change
    create_table :observations do |t|
      t.integer :follower_id, null: false, index: true
      t.integer :followed_id, null: false, index: true

      t.timestamps
    end
  end
end
