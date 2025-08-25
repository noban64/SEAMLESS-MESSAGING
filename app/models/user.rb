class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # chat room
  has_many :chat_rooms, class_name: "Chat", foreign_key: "first_user_id"
  has_many :chat_rooms_alt, class_name: "Chat", foreign_key: "second_user_id"
  # send messages table
  has_many :messages

  # friends list
  has_many :friends, class_name: "Friend", foreign_key: "friend_id" ##
  has_one :user, class_name: "Friend", foreign_key: "user_id" ##
end
