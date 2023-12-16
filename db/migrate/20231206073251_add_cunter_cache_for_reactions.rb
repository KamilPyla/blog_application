class AddCunterCacheForReactions < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :total_reactions, :integer, default: 0
    add_column :events, :total_reactions, :integer, default: 0
    add_column :comments, :total_reactions, :integer, default: 0
    
  end
end
