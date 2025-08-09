class FrontController < ApplicationController
  def index
    if user_signed_in? then
      redirect_to friend_list_path
    end
  end
end
