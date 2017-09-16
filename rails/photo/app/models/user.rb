class User < ApplicationRecord
    # データの保存前に、パスワードを暗号化するメソッド(convert_password)を実行するよう設定
  before_save :convert_password
 
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
  
  # バリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true, length:{minimum: 6}
  
end
