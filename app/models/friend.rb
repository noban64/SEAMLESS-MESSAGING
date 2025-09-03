class Friend < ApplicationRecord
  belongs_to :friend, class_name: "User"
  belongs_to :user, class_name: "User"

  #
  # before_commit :check_record_existance
  after_create :inverse_creation
  after_destroy :inverse_destruction

  private
  def check_record_existance
   if self.class.exists?(friend_id: self.user.id, user_id: self.friend.id) then
    return true
   end
   false
  end
  def inverse_creation
      if self.check_record_existance == false then
        Friend.create(friend_id: self.user.id, user_id: self.friend.id)
      end
  end
  def inverse_destruction
    if self.check_record_existance == true then
      Friend.destroy_by(friend_id: self.user.id, user_id: self.friend.id)
      puts("Destroyed the inverse!")
    end
  end
end
