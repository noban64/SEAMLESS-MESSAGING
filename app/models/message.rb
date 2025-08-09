class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  
  validates :message, length: { in: 2..256 }, presence: { message: "Message cannot be shorter than 2 characters and longer than 256!" }
end
