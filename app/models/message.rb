class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  validates :message, length: { in: 2..256 }, presence: { message: "Message cannot be shorter than 2 characters and longer than 256!" }

  # after_create :broadcast_message

  def broadcast_message
    broadcast_append_to(
    [ chat, "messages" ],
    target: "messages",
    partial: "message/messages",
    locals: { message: self }
    )
  end
end
