class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :message_threads, index: true, foreign_key: true

      t.string :content

      t.timestamps
    end
  end
end
