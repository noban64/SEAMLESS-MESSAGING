class ProfileController < ApplicationController
  def profile
      if User.exists?(id: params[:id]) then #### BIG SQLI PROBLEM -> FIX IMMEDIATELY.
          @profile = User.find(params[:id])
      else
        redirect_to root_path
      end
  end
end
