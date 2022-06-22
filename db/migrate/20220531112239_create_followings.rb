# frozen_string_literal: true

class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.boolean :requestAccepted
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :follower, index: true
      t.timestamps
    end
  end
end
