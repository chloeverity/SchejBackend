class AddEmailToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :email, :string
  end
end
