Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :books do
    resources :reviews, only:[:create]
  end

  resources :book_ownerships do
    resources :reservations, only: [ :create]
  end

  resources :reservations, only: [:index, :update ]

  resources :families, only: [:index, :create, :destroy, :update] do
    resources :adhesions, only: [:create]
  end
end
