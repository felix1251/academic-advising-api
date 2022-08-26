class AddColoumnStaffDean < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :dean, :boolean, default: false
  end
end
