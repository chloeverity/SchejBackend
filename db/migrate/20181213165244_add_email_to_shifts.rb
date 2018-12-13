# frozen_string_literal: true

class AddEmailToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :email, :string
  end
end
