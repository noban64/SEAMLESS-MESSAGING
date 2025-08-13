class ProfileController < ApplicationController
  def profile
      if User.exists?(id: params[:id]) then #### previous sqli issue, make sure to test it further.
          @profile = User.find(params[:id])
      else
        redirect_to root_path
      end
  end
end
