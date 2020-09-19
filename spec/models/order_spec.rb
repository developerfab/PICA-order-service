require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:client_id) }
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to have_many(:order_products) }

  describe '#create' do
    context 'when the parameters are valid' do
      let(:parameters) do
        {
          client_id: 23,
          total: 45000,
          status: 'open',
          comments: 'This client is important.'
        }
      end

      let(:order) { described_class.new(parameters) }

      it 'saves the order' do
        expect(order.save).to eq true
      end
    end
  end
end
