Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"

  root "landings#index"

  post "sign_up", to: "users#create"
  get "sign_up", to: "users#new"
  
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"

  post "/user/:user_id/upload/:upload_id/", to: "users#share_image_as_post"
  
  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  resources :users

  get '/s/:slug', to: 'links#show', as: :short
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
