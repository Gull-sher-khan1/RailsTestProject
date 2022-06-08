class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :followings, inverse_of: :user
  has_many :posts,  inverse_of: :user
  has_many :stories
  has_many :comments,  inverse_of: :user
  has_many :attachments
  has_many :likes, inverse_of: :user
  has_one :request, class_name: "following", foreign_key: "follower_id", inverse_of: :user

end
