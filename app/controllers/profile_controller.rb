class ProfileController < ApplicationController
  def profile
      if User.exists?(id: params[:id]) then #### previous sqli issue, make sure to test it further.
          @profile = User.find(params[:id])
      else
        flash[:notice] = "That user does not exist!"
        redirect_to root_path
      end

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
end
