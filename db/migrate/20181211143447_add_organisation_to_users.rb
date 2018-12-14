# frozen_string_literal: true

class AddOrganisationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :organisation, :string
  end
end
