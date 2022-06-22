# frozen_string_literal: true

class AddIndexToFollowing < ActiveRecord::Migration[5.2]
  def change
    add_index :followings, %i[user_id follower_id], unique: true
  end
end
