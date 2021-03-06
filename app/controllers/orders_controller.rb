class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message_error

  has_scope :find_by_client_id

  def index
    orders = apply_scopes(Order).all
    render json: orders
  end

  def show
    order = Order.find(order_id)
    if order
      render json: order
    else
      render json: { error: order.errors }
    end
  end

  def create
    my_order = Order.new(order_params)
    order_product_params.each do |order_product|
      my_order.order_products.build(order_product)
    end

    if Payer.call(order_params)
      if my_order.save
        # run the payment
        render json: my_order, status: :created
      else
        render json: { error: my_order.errors.messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Tarjeta invalida' }, status: :unprocessable_entity
    end
  end

  def update
    order = Order.find(order_id)
    order.assign_attributes(order_params)
    if order.save
      render json: order, status: :ok
    else
      render json: { error: order.errors }, status: :unprocessable_entity
    end
  end

  private

  def not_found_message_error(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def order_id
    params.require(:id)
  end

  def order_params
    params.require(:order).permit(:client_id, :total, :status, :payment_method, :credit_number_card)
  end

  def order_product_params
    params.require(:order).permit(order_products: [:product_id, :value, :count])[:order_products]
  end
end
