Kiin::Application.routes.draw do
  root "pages#inside"
  get "home", to: "pages#inside", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  get '/new_friend/:id' => 'pages#new_permit', :as => 'new_permit' 
  post '/new_friend/:id' => 'pages#create_permit', :as => 'create_permit' 
  get '/delete_friend/:id' => 'pages#destroy_permit', :as => 'delete_permit'
  get "friend/:email", to: "pages#friend_schedule", as: 'friend_schedule'

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
  end

end
