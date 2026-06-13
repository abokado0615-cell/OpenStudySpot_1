class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  # 👇 これが丸ごと抜けていたため、保存ができませんでした！
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 保存に成功したら、ユーザーの詳細画面（マイページ）に戻る
      redirect_to user_path(@user), notice: "プロフィールを更新しました！"
    else
      # 保存に失敗したら、もう一度編集画面を表示する
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # 許可する項目をすべてコンマで区切って一列に綺麗に並べました
    params.require(:user).permit(:name, :email, :image, :profile, :occupation, :study_tags, :instagram_id, :x_id, :tiktok_id)
  end
end