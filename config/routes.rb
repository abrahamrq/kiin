Kiin::Application.routes.draw do
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  get '/new_friend/:id' => 'pages#new_permit', :as => 'new_permit' 
  post '/new_friend/:id' => 'pages#create_permit', :as => 'create_permit' 
  
  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
  end

end
