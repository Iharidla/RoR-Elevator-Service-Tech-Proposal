class CreateElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :elevators do |t|
      t.integer :floor, default: 1
      t.boolean :is_blocked, default: false
      t.integer :direction, default: 0

      t.timestamps
    end
  end
end
