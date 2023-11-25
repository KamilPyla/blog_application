class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action, null: false
      t.string :ip_address
      t.string :action_subject, null: false

      t.timestamps
    end
  end
end
