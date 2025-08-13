class MessageController < ApplicationController
  before_action :authenticate_user!
  def chat
    if current_user
     @messages = Message.all.where(sender_id: current_user.id, receiver_id: params[:id]); # temporary receiver
    end
  end
  def send_message
    # @message = Message.create(sender_id: current_user_id, receiver_id: params[:id])
    @test = "Hi, this is a testing variable!"
  end
  def create
    @test = "test"
  end
  def read
    # decrypt the message
  end
  # private
  # def message_params
  # end
  # def sanitise_params
  #   sanitise(params[:message], tags: %w[b i u])
  # end
end
