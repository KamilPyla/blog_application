class CreateMessageThreads < ActiveRecord::Migration[7.1]
  def change
    create_table :message_threads do |t|
      t.string :topic
      t.string :kind
      t.references :subject, polymorphic: true

      t.timestamps
    end
  end
end
