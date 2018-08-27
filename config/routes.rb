Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "products#index"

  resources :products
  resources :carts

  # post 'carts/:id', to: 'carts#save', as: 'carts'
  # get 'carts', to: 'carts#show', as: 'cart'
  # delete 'carts_delete/:id', to: 'carts#destroy', as:'cart_delete'
end
