Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :books do
    resources :reservations, only: [ :create]
    resources :reviews, only:[:create]
  end

  resources :reservations, only: [:index, :update ]

  resources :adhesions, only: [:create, :destroy]

  resources :families, only: [:index, :create, :destroy, :update]
end
