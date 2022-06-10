class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|

      t.integer :likeable_id
      t.string  :likeable_type
      t.belongs_to :user, index: true
      t.timestamps
    end
    add_index :likes, [:likeable_type, :likeable_id]
  end
end
