# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :likeable_id
      t.string  :likeable_type
      t.belongs_to :user, index: true
      t.timestamps
    end
    add_index :likes, %i[likeable_type likeable_id]
  end
end
