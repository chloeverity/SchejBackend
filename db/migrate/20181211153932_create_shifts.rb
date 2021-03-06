# frozen_string_literal: true

class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.string :title
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
