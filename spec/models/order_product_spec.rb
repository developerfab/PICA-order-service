require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
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
