class OrderProduct < ApplicationRecord
  validates :product_id, :value, :count, presence: true

  belongs_to :order
end
