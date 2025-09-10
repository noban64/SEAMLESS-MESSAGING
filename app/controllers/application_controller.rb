class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def get_user_params_TEMP ## get this to work with all controllers that parameters
    if !params[:id]
      return "There is no profile selected!"
    end
    @requesting_user = current_user.id
    @requested_user = params[:id]
  end
end
