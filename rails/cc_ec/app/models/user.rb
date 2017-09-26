class User < ApplicationRecord
  #リレーション（データベース）
  has_many :products, dependent: :destroy
  has_many :user_likes, dependent: :destroy


  # データの保存前に、パスワードを暗号化するメソッド(convert_password)を実行するよう設定
  before_create :convert_password
 
  # パスワードを暗号化するメソッド
  def convert_password
    self.password = User.generate_password(self.password)
  end
 
  # パスワードをmd5に変換するメソッド
  def self.generate_password(password)
    # パスワードに適当な文字列を付加して暗号化する
    salt = "h!hgamcRAdh38bajhvgai17ysvb"
    Digest::MD5.hexdigest(salt + password)
  end
  
  # 投稿が特定のユーザーにいいね！されているかどうかを判定
  def check_like(product)
    self.user_likes.exists?(product_id: product.id)
  end
  
  def check_image(product,image_attribute)
    #self.products.exist?(id: product.id, #{image_attribute: image_path})
    if image_attribute==1
      self.products.exists?(id: product.id, image1: product.image1)
    elsif image_attribute==2
      self.products.exists?(id: product.id, image2: product.image2)
    else
      self.products.exists?(id: product.id, image3: product.image3)
    end
  end
  
  # バリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true, length:{minimum: 8}
  
  
  
end

