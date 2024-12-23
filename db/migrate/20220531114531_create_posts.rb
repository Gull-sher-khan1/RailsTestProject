# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :text, null: false
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
