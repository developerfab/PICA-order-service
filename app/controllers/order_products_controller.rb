# frozen_string_literal: true

class OrderProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    products = Order.find(order_id).order_products
    render json: products.to_json
  end

  private

  def order_id
    params[:order_id]
  end

  def record_not_found(message)
    render json: message.to_json, status: :unprocessable_entity
  end
end
