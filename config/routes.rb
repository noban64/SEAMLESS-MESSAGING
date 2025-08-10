Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "home" => "front#index"
  post "login" => "devise#new_user_sessiono"

  get "profile/:id" => "profile#profile", as: "profile"

  get "friends" => "friend#list"

  get "chat/:id" => "message#chat", as: "chat"


  # defacto route
  root "front#index"
end
