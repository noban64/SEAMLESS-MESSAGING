class ChatController < ApplicationController
  before_action :authenticate_user!

  def show
    if Chat.exists?(id: params[:id])
      @chat = Chat.find(params[:id])
      if (@chat.first_user.id != current_user.id) && (@chat.second_user.id != current_user.id)
        flash[:notice] = "How'd you get here?! You don't belong in this chat!"
        redirect_to root_path
      end
    else
      # create()
      flash[:notice] = "This chat doesn't exist."
      redirect_to root_path
    end
  end

  def new
    @chat = Chat.new(first_user_id: current_user.id, second_user_id: params[:id])

    render json: {}, status: 204
  end

  def create
    @chat = Chat.new(first_user_id: current_user.id, second_user_id: params[:id])

    begin
      @chat.save
      redirect_to @chat

    rescue => error
      puts error
    end

    # if @chat.save then
    #   redirect_to @chat
    # else
    #   flash[:notice] = "There was an error starting the chat. Please try again."
    #   redirect_to root_path
    # end
  end
end
