class AddJobTitleToShift < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :job_title, :string
  end
end
