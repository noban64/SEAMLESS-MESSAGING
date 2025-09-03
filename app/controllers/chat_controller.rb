class ChatController < ApplicationController
  before_action :authenticate_user!, :get_user_params, :verify_chat

  def get_user_params
    if params[:format]
      @new_chat_user = User.find(params[:format])
      @chat_one = Chat.where(first_user_id: current_user.id, second_user_id: @new_chat_user.id)
      @chat_two = Chat.where(second_user_id: current_user.id, first_user_id: @new_chat_user.id)
    end
  end
  def verify_chat
  end
  def show
    if Chat.exists?(id: params[:id])
      @chat = Chat.find(params[:id])
      if (@chat.first_user.id != current_user.id) && (@chat.second_user.id != current_user.id)
        flash[:notice] = "How'd you get here?! You don't belong in this chat!"
        redirect_to root_path
      end
    else
      flash[:notice] = "This chat doesn't exist."
      redirect_to root_path
    end
  end

  def new
    @chat = Chat.new(first_user_id: current_user.id, second_user_id: @new_chat_user)

    render json: {}, status: 204
  end

  def create
    if Chat.exists?(@chat_one) || Chat.exists?(@chat_two)
      @chat = Chat.find(@chat_one) || Chat.find(@chat_two)
      puts ("Chat is already created. Redirecting to: " + @chat.id)
      redirect_to @chat
    else
      begin
        @chat = Chat.new(first_user_id: current_user.id, second_user_id: @new_chat_user.id)
        @chat.save
        puts @chat.id

        redirect_to chat_path(@chat)

      rescue => error
        puts error
        flash[:notice] = "There was an error starting the chat. Please try again."
        redirect_to root_path
      end
    end
  end
end
