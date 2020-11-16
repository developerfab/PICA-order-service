require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:client_id) }
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:credit_number_card) }
  it { is_expected.to validate_presence_of(:payment_method) }
  it { is_expected.to have_many(:order_products) }

  describe '#create' do
    let(:parameters) do
      {
        client_id: 23,
        total: 45000,
        credit_number_card: '4509953566233704',
        status: 'active',
        comments: 'This client is important.',
        payment_method: 'credit1'
      }
    end

    subject { described_class.new(parameters) }

    context 'when the parameters are valid' do
      it 'saves the order' do
        expect(subject.save).to eq true
      end
    end

    context 'when creates a order_product also' do
      let(:product) { order_products(:luigis_restaurant) }
      let(:order_product) { JSON.parse(product.dup.to_json) }

      before do
        travel_to Time.zone.local(2020, 11, 16, 00, 00, 00)

        stub_request(:get, "http://#{ENV['CAMPAIGN_SERVICE_HOST']}:#{ENV['CAMPAIGN_SERVICE_PORT']}/campaigns?filter_by_frame=16/11/2020&filter_by_product_id=#{product.product_id}").with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }
        ).to_return(body: '[]', headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3' })

        subject.order_products.build(order_product)
      end

      it 'saves both objects' do
        expect{ subject.save }.to change(Order, :count).by(1)
          .and change(OrderProduct, :count).by(1)
      end

      after { travel_back }
    end
  end
end
