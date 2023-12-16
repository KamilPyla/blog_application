class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :subject, polymorphic: true

      t.timestamps
    end
  end
end
