class UsersController < ApplicationController
  # 詳細表示の機能だけ残す
  def show
    @user = User.find(params[:id])
  end

  # プロフィール更新（update）はDevise側で制御するので、ここからは削除してOK
end