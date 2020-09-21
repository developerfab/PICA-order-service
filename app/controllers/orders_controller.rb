class OrdersController < ApplicationController
  def index
    orders = Order.all
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

  private

  def order_id
    params.require(:id)
  end
end
