class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats, id: :uuid do |t|
      t.references :first_user, null: false
      t.references :second_user, null: false

      t.timestamps
    end
    add_foreign_key :chats, :users, column: :first_user_id, primary_key: :id
    add_foreign_key :chats, :users, column: :second_user_id, primary_key: :id
  end
end
