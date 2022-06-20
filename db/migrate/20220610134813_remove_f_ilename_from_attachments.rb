class RemoveFIlenameFromAttachments < ActiveRecord::Migration[5.2]
  def change
    remove_column :attachments, :pic_name
  end
end
