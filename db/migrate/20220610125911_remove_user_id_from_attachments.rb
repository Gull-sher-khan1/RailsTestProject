# frozen_string_literal: true

class RemoveUserIdFromAttachments < ActiveRecord::Migration[5.2]
  def change
    remove_column :attachments, :user_id
  end
end
