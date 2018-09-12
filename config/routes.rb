Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "products#index"

  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show]
  resources :carts
  resources :addresses do
    member do
      post 'change_selected'
    end
  end

  get 'orders/checkout', to: 'orders#checkout'
  post 'orders/execute-payment', to: 'orders#execute_payment'
  resources :orders
end
