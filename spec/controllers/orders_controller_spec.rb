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

    context "when the parameter aren't valid" do
      context "when the id doesn't exist" do
        let(:message_error) do
          {
            "error": "Couldn't find Order with 'id'=222222"
          }
        end

        before do
          get :show, params: { id: 222222 }
        end

        it 'returns a message error about id not found' do
          expect(JSON.parse(response.body.to_json)).to eq(message_error.to_json)
        end
      end
    end
  end

  describe '#create' do
    context 'when the parameters are valid' do
      let(:create_params) do
        {
          order: {
            client_id: 20,
            total: 10_000,
            status: 'active',
            payment_method: 'credit1',
            credit_number_card: "4509953566233704",
            order_products: [
              {
                product_id: 10,
                value: 5_000,
                count: 1
              },
              {
                product_id: 11,
                value: 5_000,
                count: 1
              }
            ]
          }
        }
      end

      before do
        post :create, params: create_params
      end

      it { expect(response).to have_http_status(:created) }

      it 'creates a new order' do
        expect(JSON.parse(response.body, symbolize_names: true)).to include(:id, :client_id, :total, :status, :comments)
      end
    end

    context 'when missing parameters' do
      let(:create_params) do
        {
          order: {
            total: 10_000,
            status: 'active',
            credit_number_card: "4509953566233704",
            order_products: [
              {
                product_id: 10,
                value: 5_000,
                count: 1
              },
              {
                product_id: 11,
                value: 5_000,
                count: 1
              }
            ]
          }
        }
      end

      before do
        post :create, params: create_params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'returns message about missing parameter' do
        expect(JSON.parse(response.body)['error']['client_id']).to eq(["can't be blank"])
      end
    end
  end
end
