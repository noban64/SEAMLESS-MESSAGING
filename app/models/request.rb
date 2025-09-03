class Request < ApplicationRecord
  belongs_to :requesting_user, class_name: "User"
  belongs_to :user, class_name: "User"

  after_initialize :init

  def init
    puts (self.to_s)
    self.denied = false
  end
end
