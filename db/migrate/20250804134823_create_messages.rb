class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :chat, type: :uuid, null: false
      t.string :message
      t.timestamps
    end
  end
end
