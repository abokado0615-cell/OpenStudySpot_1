Rails.application.routes.draw do
  # 直下に配置したコントローラーを読み込む設定
  devise_for :users, controllers: { registrations: 'user_registrations' }

  devise_scope :user do
    get 'users/edit', to: 'user_registrations#edit', as: :edit_user_registration
  end

  resources :users, only: [:show]
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  root 'tweets#index' 
end