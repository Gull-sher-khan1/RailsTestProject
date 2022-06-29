# frozen_string_literal: true

module UsersHelper
  def get_request(profile_user_id, current_user_id)
    Following.get_request(profile_user_id, current_user_id)
  end

  def get_user_attachments(id, attachments)
    attachments.where(attachable_id: id, attachable_type: 'User').first
  end

  def get_attachments_by_user_id(user, attachments)
    attachments.where(attachable_id: user.id).pluck(:uri)[0]
  end

  def get_found_user_attachments(found_users)
    Attachment.where(attachable_type: 'User', attachable_id: found_users.pluck(:id))
  end
end
