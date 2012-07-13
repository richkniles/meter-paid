class ChangeAmountCentsToDefault0InSchedule < ActiveRecord::Migration
  def change
    change_column :schedules, :amount_cents, :integer, default: 0
  end
end
