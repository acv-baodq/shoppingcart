Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "products#index"

  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show]
  resources :carts

  resources :orders, only: [:index, :create]

  # get 'cart_init', to: 'carts#init_data'
  # post 'carts/:id', to: 'carts#add'
  # post 'carts_quantity', to: 'carts#change_quantity'
  # get 'carts', to: 'carts#show'
  # delete 'carts_delete/:id', to: 'carts#destroy', as:'cart_delete'
end
