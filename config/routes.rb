Rails.application.routes.draw do
  get 'home', to: 'pages#home'
  root 'pages#home'
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
  resources :learning_sessions, only: [:new, :create]
  match '*unmatched', to: 'application#render_404', via: :all
end
