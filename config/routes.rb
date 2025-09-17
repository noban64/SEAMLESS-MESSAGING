Rails.application.routes.draw do
  devise_for :users

  match "404" => "errors#not_found", via: :all
  match "500" => "errors#server_errors", via: :all

  get "home" => "front#index"

  get "profile/:id" => "profile#profile", as: "profile"

  get "search" => "search#show", as: "search"

  resources :friend, only: %w[show create destroy]
  resources :profile, only: %w[show] do
    resources :request, only: %w[show create] do
      post "/decision", to: "request#request_decision"
    end
  end

  get "chat/create" => "chat#create", as: "chat_creation"
  resources :chat, only: %w[show create] do
    resources :message, only: %w[create]
  end
  # end
  # defacto route
  root "front#index"
end
