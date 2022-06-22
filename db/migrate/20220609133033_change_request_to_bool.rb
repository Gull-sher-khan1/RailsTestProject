# frozen_string_literal: true

class ChangeRequestToBool < ActiveRecord::Migration[5.2]
  def change
    change_table :followings do |_t|
      change_column :followings, :request_accepted, 'boolean USING CAST(request_accepted AS boolean)'
    end
  end
end
