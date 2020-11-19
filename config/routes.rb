Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :books do
    resources :reviews, only:[:create, :update, :new, :edit]
    resources :wishlists, only:[:create]
  end

  resources :reviews, only:[:destroy]

  resources :book_ownerships do
    resources :reservations, only: [ :create]
  end

  resources :wishlists, only: [:index, :destroy]

  resources :reservations, only: [:index, :update ]

  resources :adhesions, only: [:create, :destroy]

  resources :families, only: [:index, :create, :destroy, :update]
end
