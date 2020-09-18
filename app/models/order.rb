class Order < ApplicationRecord
  validates :client_id, :total, :status, presence: true
end
