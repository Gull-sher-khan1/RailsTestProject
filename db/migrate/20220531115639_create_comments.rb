# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :commentable_id
      t.string  :commentable_type
      t.belongs_to :user, index: true
      t.timestamps
    end

    add_index :comments, %i[commentable_type commentable_id]
  end
end
