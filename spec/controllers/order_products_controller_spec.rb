require 'rails_helper'

RSpec.describe OrderProductsController, type: :request do
  describe '#index' do
    context 'when the order exist' do
      let(:my_order) { orders(:travel_to_europe) }
      let(:response_body) { JSON.parse(response.body) }

      before do
        get order_order_products_path(order_id: my_order.id)
      end

      it { expect(response).to have_http_status(200) }

      it 'list the order products' do
        expect(response_body.count).to eq(2)
      end
    end

    context "when the order doesn't exist" do
      let(:response_body) { JSON.parse(response.body) }

      before do
        get order_order_products_path(order_id: 123)
      end

      it { expect(response).to have_http_status(422) }
    end
  end
end
