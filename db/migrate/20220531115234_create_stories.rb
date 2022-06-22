# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
