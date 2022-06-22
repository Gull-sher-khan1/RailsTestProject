# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :text, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :likes, as: :likeable
end
