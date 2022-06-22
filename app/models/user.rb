# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :followings, inverse_of: :user
  has_many :posts, inverse_of: :user
  has_many :stories
  has_many :comments, inverse_of: :user
  has_many :likes, inverse_of: :user
  has_many :requests, class_name: 'following', foreign_key: 'follower_id', inverse_of: :follower
  has_one :attachment, as: :attachable, dependent: :destroy
end
