Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "products#index"

  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show]
  resources :carts
  resources :addresses
  resources :orders, only: [:index, :create]
end
