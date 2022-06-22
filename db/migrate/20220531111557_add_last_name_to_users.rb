# frozen_string_literal: true

class AddLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :LastName, :string
  end
end
