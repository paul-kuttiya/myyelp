Rails.application.routes.draw do
  root to: 'reviews#index'
  get 'ui(/:action)', controller: 'ui'

  get '/signup', to: "users#new"
  resources :users, only: [:create, :show]

  get '/login', to: "sessions#new"
  resources :sessions, only: [:create, :show]
  
  get '/logout', to: "sessions#destroy"

  resources :businesses, only: [:index, :show] do
    resources :reviews, only: [:new, :create,:edit, :update] 
  end

  resources :reviews, only: [:index]
end
