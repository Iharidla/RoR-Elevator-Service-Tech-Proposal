class OrdersController < ApplicationController
  before_action :order_params

  def pickup
    add_order(0)
  end

  def dropoff
    add_order(1)
  end

  private
    def add_order(state)
      @order = Order.new(state: state, floor: order_params)

      if @order.save
        render json: @order
      else
        render json: @order.errors, status: 422
      end
    end

    def order_params
      params.require(:floor)
    end
end
