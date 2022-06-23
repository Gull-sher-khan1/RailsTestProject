# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :uri, null: false, default: 'user.jpg'
      t.string :pic_name
      t.integer :attachable_id
      t.string  :attachable_type
      t.belongs_to :user, index: true
      t.timestamps
    end
    add_index :attachments, %i[attachable_type attachable_id]
  end
end
