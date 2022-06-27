# frozen_string_literal: true

module ApplicationHelper
  def request_count(id)
    Following.request_count(id)
  end

  def user_attachment(id)
    Attachment.users_attachments([id])
  end
end
