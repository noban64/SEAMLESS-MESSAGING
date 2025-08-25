class Chat < ApplicationRecord
  belongs_to :first_user, class_name: "User"
  belongs_to :second_user, class_name: "User"
  has_many :messages

  after_create :broadcast_message

  def broadcast_message
    broadcast_append_to(
    [ chat, "messages" ],
    target: "messages",
    partial: "message/messages",
    locals: { message: self }
    )
  end
end
