class FrontController < ApplicationController
  def index
    if user_signed_in? then
      # redirect_to friends_path
      puts "you're logged in!"
    end
  end
end
