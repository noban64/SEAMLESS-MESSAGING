class MessageController < ApplicationController
  before_action :authenticate_user!, :set_chat_room
  def message
  end
  def set_chat_room
    @current_chat = Chat.find(params[:chat_id])
  end
  def new
    @message = Message.new()
  end
  def create
    @test = "Hi, this is a testing variable!"
      if @current_chat.first_user.id == current_user.id || @current_chat.second_user.id == current_user.id
      @message = @current_chat.messages.build(message_params)
      @message.user_id = current_user.id

        begin
        @message.save
        @message.attach(params[:chat_images]) if params[:chat_images] != nil

        puts ("--------")
        puts (@message)
        puts ("--------")

      rescue => error
        puts ("--------")
        print(@message.errors)
        puts ("AN ERROR OCCURED!")
        puts (error)
        puts ("--------")
      end
      redirect_to @current_chat
      # render json: {}, status: :no_content  # i cant get websockets to work for some reason...
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
