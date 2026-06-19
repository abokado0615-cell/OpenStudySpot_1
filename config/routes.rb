Rails.application.routes.draw do
  # フォルダ指定をやめて、ファイル名を直で指定します
  devise_for :users, controllers: {
    registrations: 'user_registrations'
  }

  devise_scope :user do
    get 'users/edit', to: 'user_registrations#edit', as: :edit_user_registration
  end

  resources :users, only: [:show]
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  root 'tweets#index' 
end