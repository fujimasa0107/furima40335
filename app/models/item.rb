class Item < ApplicationRecord
  belongs_to :user
  has_one :buyer
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :condition, :shipping_cost, :prefecture, :shipping_date

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank" } 
end
