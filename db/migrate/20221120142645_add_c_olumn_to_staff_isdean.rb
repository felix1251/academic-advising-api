class AddCOlumnToStaffIsdean < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :is_dean, :boolean, :default => false
  end
end
