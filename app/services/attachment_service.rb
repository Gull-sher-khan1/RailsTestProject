# frozen_string_literal: true

class AttachmentService
  def self.create(attachment, story, attachment_parameter)
    redirect_to root_url, alert: 'can not create story' unless story.save
    attachment = story.build_attachment
    attachment.uri = CloudinaryService.upload(attachment_parameter)
    StoryCleanupJob.set(wait: 60 * 60 * 24).perform_later(attachment, story) if attachment.save
    attachment
  end

  def self.update(id, atttachments_parameter)
    attachments = Attachment.post_attachments(id)
    redirect_to root_url, alert: 'can not update post' if attachments.nil?
    CloudinaryService.batch_destroy(attachments)
    return if atttachments_parameter.nil?
    post = Post.find_by(id: id)
    redirect_to root_url, alert: 'can not find post' if post.nil?
    CloudinaryService.batch_upload(post, atttachments_parameter)
    return post, attachments
  end

end
