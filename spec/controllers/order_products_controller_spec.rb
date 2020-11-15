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

  describe '#create' do
    context 'when parameter are valid' do
      let(:my_order) { orders(:travel_to_europe) }
      let(:response_body) { JSON.parse(response.body) }

      let(:params) do
        {
          product: {
            product_id: 15,
            value: 15_000,
            count: 2
          }
        }
      end

      before do
        post order_order_products_path(order_id: my_order.id, params: params)
      end

      it { expect(response).to have_http_status(201) }

      it 'creates the new product' do
        expect(response_body).to include('order_id')
        expect(response_body).to include('product_id')
        expect(response_body).to include('value')
        expect(response_body).to include('count')
      end
    end

    context 'when the parameters are invalid' do
      let(:my_order) { orders(:travel_to_europe) }
      let(:response_body) { JSON.parse(response.body) }

      let(:params) do
        {
          product: {
            product_id: 15,
            count: 2
          }
        }
      end

      before do
        post order_order_products_path(order_id: my_order.id, params: params)
      end

      it { expect(response).to have_http_status(422) }

      it 'returns a message error' do
        expect(response_body).to eq({"value"=>["can't be blank"]})
      end
    end
  end
end
