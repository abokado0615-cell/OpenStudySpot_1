class ApplicationController < ActionController::Base
  before_action :set_suggested_tags
  
  def set_suggested_tags
   # ここに候補に出したいタグを並べる
   @suggested_tags = ["数学", "英語", "受験勉強", "テスト勉強", "資格試験"]
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # アカウント更新時に、新しく追加した項目（学年、SNS、タグなど）の保存をDeviseに許可します
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :profile, :occupation, :study_tags, :instagram_id, :x_id, :tiktok_id])
    
    # 新規登録（サインアップ）の時も名前などを保存させたい場合は、ここも許可しておきます
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :profile, :occupation, :study_tags, :instagram_id, :x_id, :tiktok_id])
  end

end