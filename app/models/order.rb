class Order < ApplicationRecord
  belongs_to :users

  has_many :order_products
  has_many :orders, through: :order_products

end
