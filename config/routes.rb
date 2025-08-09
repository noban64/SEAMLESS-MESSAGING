Rails.application.routes.draw do
  get "friend/list"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html



  post "login" => "devise#new_user_sessiono"

  get "home" => "front#index"
  root "front#index"
end
