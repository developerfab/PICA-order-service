require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  before do
    travel_to Time.zone.local(2020, 11, 16, 00, 00, 00)

    stub_request(:get, "http://#{ENV['CAMPAIGN_SERVICE_HOST']}:#{ENV['CAMPAIGN_SERVICE_PORT']}/campaigns?filter_by_frame=16/11/2020&filter_by_product_id=23").with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
      }
    ).to_return(body: '[]', headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3' })
  end

  after { travel_back }

  it { is_expected.to validate_presence_of(:product_id) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:count) }
  it { is_expected.to belong_to(:order) }

  describe '#save' do
    context 'when are send parameters valid' do
      let(:my_order) { orders(:travel_to_europe) }

      let(:parameters) do
        {
          product_id: 23,
          value: 5000,
          count: 2,
        }
      end

      subject do
        described_class.new(parameters).tap do |order_product|
          order_product.order = my_order
        end
      end

      it 'saves the object' do
        expect(subject.save).to eq true
      end
    end
  end
end
