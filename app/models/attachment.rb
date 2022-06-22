# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  scope :posts_attachments, -> (posts) {where(attachable_id: posts.pluck(:id), attachable_type: 'Post')}
  scope :random_stories, -> {where(attachable_type: 'Story').order('RANDOM()').limit(7)}
  scope :users_attachments, -> (user_ids) {where(attachable_id: user_ids, attachable_type: 'User')}
  scope :post_attachments, -> (id) {where(attachable_id: id, attachable_type: 'Post')}
end
