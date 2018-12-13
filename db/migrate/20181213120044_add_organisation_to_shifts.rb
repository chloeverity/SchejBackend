class AddOrganisationToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :organisation, :string
  end
end
