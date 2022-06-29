# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :likes, as: :likeable, dependent: :destroy

  validates :text, presence: true

end
