# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :followings, inverse_of: :user, dependent: :destroy
  has_many :posts, inverse_of: :user, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :comments, inverse_of: :user, dependent: :destroy
  has_many :likes, inverse_of: :user, dependent: :destroy
  has_many :requests, class_name: 'Following', foreign_key: 'follower_id', inverse_of: :follower, dependent: :destroy
  has_one :attachment, as: :attachable, dependent: :destroy

  protected
  def confirmation_required?
    false
  end
end
