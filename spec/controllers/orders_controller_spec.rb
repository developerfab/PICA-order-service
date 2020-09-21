require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#index' do
    let(:order1){ JSON.parse(orders(:travel_to_europe).to_json) }
    let(:expected_response) { [order1] }

    before do
      get :index
    end

    it 'returns a list of orders' do
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end

  describe '#show' do
    context 'when the parameters are valid' do
      let(:my_order){ orders(:travel_to_europe) }
      let(:expected_response) { JSON.parse(my_order.to_json) }

      before do
        get :show, params: { id: my_order.id }
      end

      it 'returns a list of orders' do
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end
end
