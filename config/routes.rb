Rails.application.routes.draw do
  root 'dictionaries#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :dictionaries
  resources :words
  resources :examples
  resources :word_loaders, only: [:new, :create]
end
