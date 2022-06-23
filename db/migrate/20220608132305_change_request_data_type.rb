# frozen_string_literal: true

class ChangeRequestDataType < ActiveRecord::Migration[5.2]
  def change
    change_table :followings do |t|
      t.change :request_accepted, :string, null: false
    end
  end
end
