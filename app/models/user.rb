class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # profile customisation
  has_one_attached :profile_picture  do |pfp|
    pfp.variant :base_profile_picture, resize_to_limit: [ 175, 175 ]
    pfp.variant :message_profile_picture, resize_to_limit: [ 100, 100 ]
    pfp.variant :searched_profile_picture, resize_to_limit: [ 75, 75 ]
  end

  validates :profile_picture, blob: { content_type: [ "image/png", "image/jpg", "image/jpeg" ], size_range: 0..(2.megabytes) }


  # chat room
  has_many :chat_rooms, class_name: "Chat", foreign_key: "first_user_id", dependent: :destroy
  has_many :chat_rooms_alt, class_name: "Chat", foreign_key: "second_user_id", dependent: :destroy
  # send messages table
  has_many :messages, dependent: :destroy

  # friends list
  has_many :friends, class_name: "Friend", foreign_key: "user_id", dependent: :destroy ##
  has_many :friendships, class_name: "Friend", foreign_key: "friend_id", dependent: :destroy
  # has_many :inverse_friendships, inverse_of: :friendships, class_name: "Friend", foreign_key: "friend_id" ##
  # has_many :inverse_friends, inverse_of: :friends, class_name: "Friend", foreign_key: "user_id" ##
  # has_many :user, class_name: "Friend", foreign_key: "user_id" ##

  # request list
  has_many :requesting, class_name: "Request", foreign_key: "requesting_user_id", dependent: :destroy
  has_many :requests, class_name: "Request", foreign_key: "user_id", dependent: :destroy
end
