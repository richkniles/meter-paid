class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :meter_company_account_pin, :string
    add_column :users, :cv2, :string
    
    rename_column :schedules, :amount_cents, :minutes_to_add
  end
end
