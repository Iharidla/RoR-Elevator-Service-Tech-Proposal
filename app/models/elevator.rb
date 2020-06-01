class Elevator < ApplicationRecord
  enum direction: [ :up, :down ]

  validates :floor, inclusion: 1..10

  before_update :change_direction

  def change_direction
    if self.floor == 1
      self.direction = 0
    elsif self.floor == 10
      self.direction = 1
    end
  end
end
