
require 'rails_helper'

RSpec.describe 'Pizzas API' do
  # Initialize the test data
  let!(:order) { create(:order) }
  let!(:pizzas) { create_list(:pizza, 20, order_id: order.id) }
  let(:order_id) { order.id }
  let(:id) { pizzas.first.id }

  # Test suite for GET /orders/:order_id/pizzas
  describe 'GET /orders/:order_id/pizzas' do
    before { get "/orders/#{order_id}/pizzas" }

    context 'when order exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all order pizzas' do
        expect(json.size).to eq(20)
      end
    end

    context 'when order does not exist' do
      let(:order_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  # Test suite for GET /orders/:order_id/pizzas/:id
  describe 'GET /orders/:order_id/pizzas/:id' do
    before { get "/orders/#{order_id}/pizzas/#{id}" }

    context 'when order pizza exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the pizza' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when order pizza does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pizza/)
      end
    end
  end

  # Test suite for POST /orders/:order_id/pizzas
  describe 'POST /orders/:order_id/pizzas' do
    let(:valid_attributes) { { name: 'CheesePizza' } }

    context 'when request attributes are valid' do
      before { post "/orders/#{order_id}/pizzas", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/orders/#{order_id}/pizzas", params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /orders/:order_id/pizzas/:id
  describe 'PUT /orders/:order_id/pizzas/:id' do
    let(:valid_attributes) { { name: 'VeggiePizza' } }

    before { put "/orders/#{order_id}/pizzas/#{id}", params: valid_attributes }

    context 'when pizza exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the pizza' do
        updated_pizza = Pizza.find(id)
        expect(updated_pizza.name).to match(/VeggiePizza/)
      end
    end

    context 'when the pizza does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pizza/)
      end
    end
  end

  # Test suite for DELETE /orders/:id
  describe 'DELETE /orders/:id' do
    before { delete "/orders/#{order_id}/pizzas/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
