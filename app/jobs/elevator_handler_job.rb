class ElevatorHandlerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @elevator = Elevator.first

    Thread.new do
      check_current_floor
    end
  end

  private
    def elevator
      Elevator.first
    end

    def check_current_floor
      current_floor_orders = Order.current_floor_orders(@elevator.floor)

      if !current_floor_orders.empty?
        emergency if !Order.destroy(current_floor_orders.map(&:id))
      end

      check_dropoffs
    end

    def check_dropoffs
      dropoffs = is_direction_up ? Order.upper_dropoffs(@elevator.floor) : Order.lower_dropoffs(@elevator.floor)

      if !dropoffs.empty?
        next_floor
      else
        check_pickups
      end
    end

    def check_pickups
      pickups = is_direction_up ? Order.upper_pickups(@elevator.floor) : Order.lower_pickups(@elevator.floor)

      if !pickups.empty?
        next_floor
      else
        emergency if !@elevator.change_direction

        check_dropoffs
      end
    end

    def next_floor
      @elevator.floor = is_direction_up ? @elevator.floor.next : @elevator.floor.pred

      if @elevator.save
        puts "next floor #{@elevator.floor}"
        sleep 3
        puts 'arrived'

        check_current_floor
      else
        emergency
      end
    end

    def is_direction_up
      @elevator.is_direction_up
    end

    def emergency
      @elevator.is_blocked = true

      if @elevator.save
        puts 'Elevator is broken. Try to survive and good luck...'.red
      else
        puts 'No one can help you'.red
      end
    end
end
