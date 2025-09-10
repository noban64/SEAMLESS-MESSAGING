class FriendController < ApplicationController
  before_action :authenticate_user!
  # before_action :get_user_params, only: [ "create" ]
  before_action :get_user_params, :find_friendship, only: [ "destroy" ]

  def get_user_params
    @requesting_user = current_user.id
    @requested_user = params[:friend_data]
  end

  def find_friendship
    @friendship = Friend.where(user_id: current_user.id, friend_id: params[:friend_data])
  end
  def show
    @friends_list = current_user.friendships
    @test_list = User.all()
  end

  # def create
  # MOVED TO REQUEST CONTROLLER TO AVOID COUNTLESS REDIRECTS
  #     @friend = Friend.new(friend_id: @requested_user, user_id: @requesting_user)
  #     ## must create unqiue index on friendlist
  #     begin
  #       @friend.save
  #       redirect_to friends_list_path
  #     rescue => error
  #       puts error
  #     end
  # end

  def destroy
  begin
    friendship = Friend.find(@friendship)
    friendship.destroy
  rescue => error
    puts error
  end
  flash[:notice] = "Friend successfully deleted!"
  redirect_to profile_path(@requested_user)
  end
end
