class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  ## for pagination
  include Pagy::Backend
  Pagy::DEFAULT[:limit] = 10 # items per page
  Pagy::DEFAULT[:size]  = 9  # nav bar links
  # Better user experience handled automatically
  require "pagy/extras/overflow"
  Pagy::DEFAULT[:overflow] = :last_page
  ## pagination config end

  def get_user_params_TEMP ## get this to work with all controllers that parameters
    if !params[:id]
      return "There is no profile selected!"
    end
    @requesting_user = current_user.id
    @requested_user = params[:id]
  end
end
