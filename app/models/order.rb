class Order < ApplicationRecord
  validates :client_id, :total, :status, presence: true

  has_many :order_products
end
