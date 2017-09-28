class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  paginates_per 9
  # バリデーション
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
end
