class CreateEmergencyShiftSwapsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :emergency_requests do |t|
        t.integer :emergency_requester_id
        t.text :comment
        t.integer :emergency_shift_id
        t.timestamps
      end
      add_foreign_key :emergency_requests, :users, column: :emergency_requester_id
      add_foreign_key :emergency_requests, :shifts, column: :emergency_shift_id
    end
  end
