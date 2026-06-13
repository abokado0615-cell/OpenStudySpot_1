class Tag < ApplicationRecord
  # validate ではなく validates にする
  # name と presence の間にスペースを入れる
  validates :name, presence: true
  
  has_many :tweet_tag_relations, dependent: :destroy
  # has_many の後のコロンの位置などを整理
  has_many :tweets, through: :tweet_tag_relations, dependent: :destroy
end