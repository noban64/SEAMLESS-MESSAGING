class UnqiueIndexOnMessages < ActiveRecord::Migration[8.0]
  def change
    add_index :messages, :id, unique: true unless index_exists?(:messages, :id)
  end
end
