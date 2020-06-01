class Elevator < ApplicationRecord
  enum direction: [ :up, :down ]

  validates :floor, inclusion: 1..10

  before_save :auto_change_direction

  scope :current_floor_orders, -> { where(floor: floor)}

  def is_direction_up
    direction == 'up'
  end

  def change_direction
    self.direction = is_direction_up ? 1 : 0
    return true if save
  end

  private
    def auto_change_direction
      if floor == 1
        self.direction = 0
      elsif floor == 10
        self.direction = 1
      end
    end
end
