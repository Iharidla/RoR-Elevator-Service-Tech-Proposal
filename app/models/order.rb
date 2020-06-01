class Order < ApplicationRecord
  enum state: [ :pickup, :dropoff ]

  validates :floor, :inclusion => 1..10

  scope :current_floor_orders, ->(floor) { where(floor: floor)}

  scope :upper_dropoffs, ->(floor) { where(state: 1).where(Order.arel_table[:floor].gt(floor))}
  scope :lower_dropoffs, ->(floor) { where(state: 1).where(Order.arel_table[:floor].lt(floor))}

  scope :upper_pickups, ->(floor) { where(state: 0).where(Order.arel_table[:floor].gt(floor))}
  scope :lower_pickups, ->(floor) { where(state: 0).where(Order.arel_table[:floor].lt(floor))}
end
