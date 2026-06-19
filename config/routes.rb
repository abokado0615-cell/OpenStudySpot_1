Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users'
  }
  resources :users, only: [:show]
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  root 'tweets#index' 
end