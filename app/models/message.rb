class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  # chat message images
  has_one_attached :chat_images do |attachment|
    attachment.variant :resize_attachment, resize_to_limit: [ 100, 100 ]
  end

  validates :chat_images, blob: { content_type: [ "image/png", "image/jpg", "image/jpeg" ], size_range: 0..(2.megabytes) }
  validates :message, length: { in: 2..256 }, presence: { message: "Message cannot be shorter than 2 characters and longer than 256!" }, unless: -> { self.chat_images.attached? }


 after_create_commit :broadcast_message

 def broadcast_message
    puts "Primary key: #{self.class.primary_key}"           # Should say "id"
    puts "ID: #{id}, Chat ID: #{chat.id}"                   # Should show UUID
   broadcast_append_to(
   "chat_#{chat_id}_msg_box",
   target: "messages",
   partial: "messages/message",
   locals: { message: self }
   )
 end
end
