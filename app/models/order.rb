class Order < ApplicationRecord
  enum state: [ :pickup, :dropoff ]

  validates :floor, :inclusion => 1..10
end
