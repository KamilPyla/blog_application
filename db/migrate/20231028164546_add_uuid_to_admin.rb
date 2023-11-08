class AddUuidToAdmin < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :uuid, :uuid, default: "gen_random_uuid()"
  end
end
