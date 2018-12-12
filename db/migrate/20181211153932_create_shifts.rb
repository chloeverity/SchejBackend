class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.string :title
      t.integer :start_time
      t.integer :end_time

      t.timestamps
    end
  end
end
