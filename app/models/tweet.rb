class Tweet < ApplicationRecord
  belongs_to :user
  attr_accessor :body

  # 💡 関連付け設定（クラスの直下に置くのがルールです）
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy

  # 入力チェックルール
  validate :at_least_one_field_present

  # 💡 タグを保存するためのメソッド（中身をここに書きます）
  def save_tags(sent_tags)
    # 必要であればここにタグ保存のロジックを書きます
  end

  private

  # 4つの項目のうち、どれか一つでも入力されているかチェックする仕組み
  def at_least_one_field_present
    if time.blank? && progress.blank? && question.blank? && body.blank?
      errors.add(:base, "勉強時間、進捗、疑問点、ひとことのいずれか1つ以上を入力してください。")
    end
  end
end