class AddColumnsToMessageThread < ActiveRecord::Migration[7.1]
  def change
    remove_column :message_threads, :subject_type, :string
    remove_column :message_threads, :subject_id, :integer
    remove_column :message_threads, :kind, :string

    add_column :message_threads, :adressee_id, :integer
    add_column :message_threads, :sender_id, :integer
    add_column :message_threads, :uuid, :uuid, default: "gen_random_uuid()"
  end
end
