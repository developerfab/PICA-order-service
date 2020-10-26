require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:client_id) }
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to have_many(:order_products) }

  describe '#create' do
    let(:parameters) do
      {
        client_id: 23,
        total: 45000,
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
      let(:order_product) { JSON.parse(order_products(:luigis_restaurant).dup.to_json) }

      before do
        subject.order_products.build(order_product)
      end

      it 'saves both objects' do
        expect{ subject.save }.to change(Order, :count).by(1)
          .and change(OrderProduct, :count).by(1)
      end
    end
  end
end
