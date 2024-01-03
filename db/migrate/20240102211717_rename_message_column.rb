class RenameMessageColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :message_threads_id, :message_thread_id
  end
end
