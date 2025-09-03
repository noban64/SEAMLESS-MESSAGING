class CreateRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :requests, id: :uuid do |t|
      t.references :requesting_user, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :denied, null: false

      t.timestamps
    end
  end
end
