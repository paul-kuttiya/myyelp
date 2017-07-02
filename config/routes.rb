Rails.application.routes.draw do
  root to: 'reviews#index'
  get 'ui(/:action)', controller: 'ui'

  get '/signup', to: "users#new"
  resources :users, only: [:create]

  get '/login', to: "sessions#new"
  resources :sessions, only: [:create]
  
  get '/logout', to: "sessions#destroy"

  resources :reviews, only: [:index]
end
