class Item < ApplicationRecord
  belongs_to :user
  has_one :buyer
end
