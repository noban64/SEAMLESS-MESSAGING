class MessagesToChat < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :messages, :chats, type: :uuid, primary_key: :id
  end
end
 