Rails.application.routes.draw do
  root 'pages#home'

  get 'home', to: 'pages#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  delete 'learn_words_again', to: 'learning_sessions#destroy'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :dictionaries
  resources :words
  resources :examples
  resources :word_loaders, only: [:new, :create]
  resources :learning_sessions, only: [:new, :create, :destroy]

   # Render dynamic PWA files from app/views/pwa/*
   get "service-worker" => "pwa#service_worker", as: :pwa_service_worker
   get "manifest" => "pwa#manifest", as: :pwa_manifest

  match '*unmatched', to: 'application#render_404', via: :all
end
