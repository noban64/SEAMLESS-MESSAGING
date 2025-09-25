class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :chat_exists?, :find_friendship, :request_exists?, only: [ "profile" ]

  def chat_exists?
    if Chat.exists?(first_user_id: current_user.id, second_user_id: params[:id])
      @chat = Chat.where(first_user_id: current_user.id, second_user_id: params[:id])
      @returned_chat = Chat.find(@chat)
    elsif Chat.exists?(second_user_id: current_user.id, first_user_id: params[:id])
      @chat = Chat.where(second_user_id: current_user.id, first_user_id: params[:id])
      @returned_chat = Chat.find(@chat)
    else
      @returned_chat = nil
    end
  end
  def request_exists?
    @request_exists  = Request.exists?(requesting_user_id: @current_user.id, user_id: params[:id], denied: false)
  end

  def find_friendship
    @already_friends  = Friend.exists?(friend_id: @current_user.id, user_id: params[:id])
  end
  def profile
      if User.exists?(id: params[:id]) then #### previous sqli issue, make sure to test it further.
          @profile = User.find(params[:id])
      else
        flash[:notice] = "That user does not exist!"
        redirect_to root_path
      end
  end

  def profile_picture
    if params[:profile_pic] != nil then 
      current_user.attach(params[:profile_pic])
    end
  end
end

