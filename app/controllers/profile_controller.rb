class ProfileController < ApplicationController
  def profile
      if User.exists?(params[:id]) then
      @profile = User.find(params[:id])
      else
        redirect_to root_path
      end
  end
end
