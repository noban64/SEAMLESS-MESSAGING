class ChatController < ApplicationController
  before_action :authenticate_user!
  def show
    # @message = Message.new(sender_id: current_user.id, receiver_id: params[:id], message: message_params)
    @message = Message.new()

    if User.exists?(id: params[:id]) && current_user
     @combined_messages = (Message.all.where(sender_id: current_user.id, receiver_id: params[:id]).or(Message.all.where(receiver_id: current_user.id, sender_id: params[:id]))).order(created_at: :asc)
     @user = User.find(params[:id])
    else
      flash[:notice] = "Who the hell are you trying to talk to? 🤣🤣🤣"
      redirect_to root_path
    end
  end
end
