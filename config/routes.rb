Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "products#index"

  resources :categories
  resources :products

  get 'cart_init', to: 'carts#init_data'
  post 'carts/:id', to: 'carts#add'
  post 'carts_quatity', to: 'carts#change_quatity'
  get 'carts', to: 'carts#show'
  delete 'carts_delete/:id', to: 'carts#destroy', as:'cart_delete'
end
