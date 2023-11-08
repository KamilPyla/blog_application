class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :subject, polymorphic: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
