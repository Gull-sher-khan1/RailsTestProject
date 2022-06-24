# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user
  has_one :attachment, as: :attachable, dependent: :destroy

  scope :get_story, -> (id) {find_by_id(id)}
end
