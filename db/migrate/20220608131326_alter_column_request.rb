# frozen_string_literal: true

class AlterColumnRequest < ActiveRecord::Migration[5.2]
  def change
    rename_column :followings, :requestAccepted, :request_accepted
  end
end
