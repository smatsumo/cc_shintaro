class Post < ApplicationRecord
  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  # 1ページあたり3項目表示
  paginates_per 3
  
  #post_fromの定義をする
  # 投稿が特定のユーザーにいいね！されているかどうかを判定
  def like_from?(user)
    self.post_likes.exists?(user_id: user.id)
  end
  
end
