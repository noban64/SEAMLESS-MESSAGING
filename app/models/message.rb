class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  # chat message images
  has_one_attached :chat_images do |attachment|
    attachment.variant :resize_attachment, resize_to_limit: [ 100, 100 ]
  end

  validates :chat_images, presence: true, blob: { content_type: [ "image/png", "image/jpg", "image/jpeg" ], size_range: 0..(2.megabytes) }
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
