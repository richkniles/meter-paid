class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :time
      t.text :meter
      t.integer :amount_cents

      t.timestamps
    end
  end
end
