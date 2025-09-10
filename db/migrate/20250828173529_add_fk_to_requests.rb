class AddFkToRequests < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :requests, :users, column: :requesting_user_id, primary_key: :id
  end
end
