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
end
