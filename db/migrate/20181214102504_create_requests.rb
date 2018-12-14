class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :shift_requester_id
      t.integer :shift_holder_id
      t.text :comment
      t.integer :requested_shift_id
      t.integer :current_shift_id
      t.timestamps
    end
    add_foreign_key :requests, :users, column: :shift_holder_id
    add_foreign_key :requests, :users, column: :shift_requester_id
    add_foreign_key :requests, :shifts, column: :requested_shift_id
    add_foreign_key :requests, :shifts, column: :current_shift_id
  end
end
