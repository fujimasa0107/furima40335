class Item < ApplicationRecord
  belongs_to :user
  has_one :buyer
  has_one_attached :image

  
end
