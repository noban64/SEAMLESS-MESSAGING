class MessageController < ApplicationController
  before_action :authenticate_user!
  def message
  end
  def new
    @message = Message.new()
  end
  def create
    @test = "Hi, this is a testing variable!"
      @current_chat = Chat.find(params[:chat_id])
      if @current_chat.first_user.id == current_user.id || @current_chat.second_user.id == current_user.id
      # might have to make sure the record exists beforehand
      # @message = Message.new({ chat_id: params[:chat_id], user_id: current_user.id }.merge(message: params[:message][:msg], chat_images: params[:chat_images]))
      @message = Message.new({ chat_id: params[:chat_id], user_id: current_user.id  }.merge(message_params))

      begin
        @message.save
        @message.attach(params[:chat_images])

        puts ("--------")
        puts (params[:msg])
        puts ("--------")

      rescue => error
        puts ("--------")
        puts (@message.to_s())
        puts (@message.errors.full_messages)
        puts ("AN ERROR OCCURED!")
        puts (error)
        puts ("--------")
      end
      redirect_to chat_path(params[:chat_id])
      # render json: {}, status: :no_content
      else
      flash[:notice] = "You dont belong in this chat!"
      redirect_to root_path
      end
  end

  def read
    # decrypt the message
  end
  # private
  def message_params
    # params.require(:message).permit(:msg)
    params.expect(message: [ :message, :chat_images ])
  end
  def sanitise_params
    sanitise(params[:message], tags: %w[b i u])
  end
end
