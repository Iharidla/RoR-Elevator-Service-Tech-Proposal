class Elevator < ApplicationRecord
  enum direction: [ :up, :down ]

  validates :floor, inclusion: 1..10

  before_save :auto_change_direction

  def change_direction
    self.direction = self.direction == "up" ? 1 : 0
    self.save
  end

  private
    def auto_change_direction
      if self.floor == 1
        self.direction = 0
      elsif self.floor == 10
        self.direction = 1
      end
    end
end
