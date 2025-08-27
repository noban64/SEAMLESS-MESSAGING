class AddUnqiueToChats < ActiveRecord::Migration[8.0]
  def change
    add_index :chats, :id, unique: true unless index_exists?(:chats, :id)
  end
end
