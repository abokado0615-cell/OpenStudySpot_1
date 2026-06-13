class User < ApplicationRecord
  # デバイス（ログイン機能）の設定が上の方に数行書いてあるはずです（それはそのまま残してください）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy

  has_one_attached :image

  # 💡 復活ポイント①：ユーザー側からも「いいね」の仕組みを紐付けます！
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 💡 復活ポイント②：すでにいいねしたかどうかをチェックする魔法の仕組み！
  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  # 💡 復活ポイント③：もしアプリがfavoritesという名前だった場合も想定して、両方用意しておきます！
  def already_favorited?(tweet)
    self.favorites.exists?(tweet_id: tweet.id)
  end
end