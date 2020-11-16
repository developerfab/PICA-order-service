class OrderProduct < ApplicationRecord
  validates :product_id, :value, :count, presence: true

  belongs_to :order

  before_save :find_in_campaigns

  private

  def find_in_campaigns
    campaigns = JSON.parse(HTTParty.get("http://#{ENV['CAMPAIGN_SERVICE_HOST']}:#{ENV['CAMPAIGN_SERVICE_PORT']}/campaigns?filter_by_frame=#{Time.current.strftime('%d/%m/%Y')}&filter_by_product_id=#{self.product_id}").body)
    if campaigns.any?
      campaign = campaigns.first
      product = JSON.parse(HTTParty.get("http://#{ENV['CAMPAIGN_SERVICE_HOST']}:#{ENV['CAMPAIGN_SERVICE_PORT']}/campaigns/#{campaign['id']}/product_campaigns/#{self.product_id}").body)
      self.value = product['value'].to_f * self.count
    end
  end
end
