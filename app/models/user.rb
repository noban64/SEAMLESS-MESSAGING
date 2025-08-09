class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # send messages table
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"

  # friends list
  has_many :friends, class_name: "Friend", foreign_key: "friend_id" ##
  has_one :user, class_name: "Friend", foreign_key: "user_id" ##
end
