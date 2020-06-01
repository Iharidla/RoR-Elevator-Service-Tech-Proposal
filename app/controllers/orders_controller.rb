class OrdersController < ApplicationController
  before_action :check_elevator

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
        binding.pry
        render json: @order.errors, status: 422
      end
    end

    def check_elevator
      if Elevator.first.is_blocked
        render json: 'Elevator is broken! Please restart it.', status: 422
      end
    end

    def order_params
      params.require(:floor)
    end
end
