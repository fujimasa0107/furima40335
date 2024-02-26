Rails.application.routes.draw do
  devise_for :users
  
  root to: 'items#index'
  resources :users
  resources :items, only: [:index, :new, :create, :show,] do
    resources :buyers, only: [:index, :create]
  end
end