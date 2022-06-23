# frozen_string_literal: true

class AddFirstNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :FirstName, :string, null: false
  end
end
