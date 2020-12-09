class Order < ApplicationRecord
  validates :client_id, :total, :status, :payment_method, :credit_number_card, presence: true

  has_many :order_products

  enum status: { pending: 'pending', active: 'active', cancelled: 'cancelled', closed: 'closed', paid: 'paid' }

  accepts_nested_attributes_for :order_products

  scope :find_by_client_id, -> (client_id) { where(client_id: client_id) }

  before_save :calcule_total
  before_save :send_order

  private

  def calcule_total
    self.total = order_products.map(&:value).sum
  end

  def send_order
    if(status_changed? && active?)
      unless Orderer.call(self)
        self.status = :cancelled
      end
    end
  end
end
