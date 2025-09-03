class FriendController < ApplicationController
  before_action :authenticate_user!, :get_user_params

  def get_user_params
    @requesting_user = current_user.id
    @requested_user = params[:id]
  end
    def list
      @friends_list = current_user.friends
      @test_list = User.all()
    end

    def create
      @friend = Friend.new(friend_id: @requested_user, user_id: @requesting_user)
      ## must create unqiue index on friendlist
      begin
        @friend.save
        redirect_to friends_list_path
      rescue => error
        puts error
      end
    end
end
