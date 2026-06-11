Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:create]

  resources :products do
    resources :reviews, only: [:create]
    post "add_to_cart", on: :member, to: "line_items#create"
  end

  resources :reviews, only: [:edit, :update, :destroy]

  resources :categories, except: [:show]

  resource :cart, only: [:show] do
    post :checkout
  end

  resources :line_items, only: [:update, :destroy]

  resources :orders, only: [:index, :show]
end
