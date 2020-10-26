class Order < ApplicationRecord
  validates :client_id, :total, :status, :payment_method, presence: true

  has_many :order_products

  enum status: [:active, :pending, :cancelled, :closed, :paid]
  accepts_nested_attributes_for :order_products
end
