class AddUuidToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uuid, :uuid, default: "gen_random_uuid()"
  end
end
