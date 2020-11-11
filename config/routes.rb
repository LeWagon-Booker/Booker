Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  get '/home', to: 'pages#home'

  resources :books do
    resources :reservations, only: [ :create]
    resources :reviews, only:[:create]
  end
  resources :reservations, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
