class FriendController < ApplicationController
  before_action :authenticate_user!
    def list
      # @testlist = current_user.friends
      @testlist = User.all();
    end
end
