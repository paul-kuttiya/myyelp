Rails.application.routes.draw do
  root to: 'reviews#index'
  get 'ui(/:action)', controller: 'ui'

  get '/signup', to: "users#new"
  resources :users, only: [:create]
  
  resources :reviews, only: [:index]
end
