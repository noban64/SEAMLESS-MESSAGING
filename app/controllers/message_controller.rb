class MessageController < ApplicationController
  def chat
     @messages = Message.all.where(sender_id: current_user.id, receiver_id: current_user.id); # temporary receiver
  end



  # def send
  #   # @message = Message.create(sender_id: current_user_id, receiver_id: params[:id])
  # end

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
