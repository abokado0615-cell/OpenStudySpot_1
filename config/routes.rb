Rails.application.routes.draw do
  # 💡 1. ログイン・ログアウトの基本ルール
  devise_for :users

  # 💡 2. 大事な追加：もしGET通信でログアウトに来ちゃっても、ちゃんとログアウトさせる魔法の逃げ道！
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # 3. ユーザーマイページのルール
  resources :users, only: [:show]

  # 4. 投稿（tweets）関連のルール
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  # アプリのトップ画面の設定
  root 'tweets#index' 
end