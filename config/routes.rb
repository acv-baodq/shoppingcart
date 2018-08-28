Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "products#index"

  resources :products

  post 'carts/:id', to: 'carts#add'
  get 'carts', to: 'carts#show'
  delete 'carts_delete/:id', to: 'carts#destroy', as:'cart_delete'
end
