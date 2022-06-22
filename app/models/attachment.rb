# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  scope :post_attachments, -> (posts) {where(attachable_id: posts.pluck(:id), attachable_type: 'Post')}
end
