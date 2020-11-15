# frozen_string_literal: true

class OrderProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    products = Order.find(order_id).order_products
    render json: products.to_json
  end

  def create
    product = OrderProduct.new(product_params)
    product.order_id = order_id

    if product.save
      render json: product.to_json, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    product = OrderProduct.find(params[:id])

    if product.delete
      render json: product.to_json, status: :ok
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_id, :value, :count)
  end

  def order_id
    params[:order_id]
  end

  def record_not_found(message)
    render json: message.to_json, status: :unprocessable_entity
  end
end
