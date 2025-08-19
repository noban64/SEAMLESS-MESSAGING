class MessageController < ApplicationController
  before_action :authenticate_user!
  def message
  end
  def new
    @message = Message.new()
  end
  def create
    @test = "Hi, this is a testing variable!"

    @message = Message.new(sender_id: current_user.id, receiver_id: params[:chat_id], message: params[:message][:msg])


    # if @message.save then
    #   puts ("--------")
    #   puts ("Message: #{@message} has been saved")
    #   puts ("--------")
    # else
    #   puts ("--------")
    #   puts ("There was an error")
    #   puts ("--------")
    # end

    begin
      @message.save
      puts ("--------")
      puts (params[:msg])
      puts ("--------")

    rescue => error
      puts ("--------")
      puts (error)
      puts ("--------")
    end
    redirect_to chat_path(params[:chat_id])
  end

  def read
    # decrypt the message
  end
  # private
  def message_params
    params.require(:message).permit(:msg)
  end
  def sanitise_params
    sanitise(params[:message], tags: %w[b i u])
  end
end
