# frozen_string_literal: true

class AddNameAndMobileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :mobile, :string
  end
end
