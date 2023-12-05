class AddCunterCacheToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :total_blocked, :integer, default: 0
    add_column :users, :total_followed, :integer, default: 0
    add_column :users, :total_followers, :integer, default: 0
    add_column :users, :total_posts, :integer, default: 0
    add_column :users, :total_events, :integer, default: 0
  end
end
