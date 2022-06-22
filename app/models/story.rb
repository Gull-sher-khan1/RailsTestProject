# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :likes, as: :likeable
end
