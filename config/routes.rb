Rails.application.routes.draw do
  devise_for :users

  match "404" => "errors#not_found", via: :all
  match "500" => "errors#server_errors", via: :all


  get "home" => "front#index"
  post "login" => "devise#new_user_sessiono"

  get "profile/:id" => "profile#profile", as: "profile"

  get "friends" => "friend#list"

  # get "chat/:id" => "chat#show", as: "chat"

  # post "chat/:id/message/new" => "message#new", as: "new_message"
  resources :chat, only: %w[show new create] do
    resources :message, only: %w[new create]
  end
  # end
  # defacto route
  root "front#index"
end
