Rails.application.routes.draw do
  get 'families/index'
  devise_for :users
  root to: 'pages#home'

  resources :books do
    resources :reservations, only: [ :create]
    resources :reviews, only:[:create]
  end

  resources :reservations, only: [:index, :update ]
  resources :families, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
