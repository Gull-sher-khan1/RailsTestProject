# frozen_string_literal: true

module ApplicationHelper
  def request_count(id)
    Following.request_count(id)
  end

  def user_attachment(id)
    Attachment.users_attachments([id])
  end

  def modify_found_users(users)
    if users.first==nil
      [User.new]
    else
      users
    end
  end

  def get_user_likes(post_id,current_user_id)
    Like.get_user_likes(post_id,current_user_id)
  end

  def get_post_attachments(posts_attachments, id)
    posts_attachments.where(attachable_id: id)
  end
end
