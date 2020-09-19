class Order < ApplicationRecord
  validates :client_id, :total, :status, presence: true

  has_many :order_products

  accepts_nested_attributes_for :order_products
end
