class ReaddMessageIndexes < ActiveRecord::Migration[8.0]
  def change
    remove_index :messages, :id
    add_index :messages, :id, unique: true
  end
end
