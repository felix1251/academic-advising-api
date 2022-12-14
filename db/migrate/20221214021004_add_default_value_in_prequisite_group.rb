class AddDefaultValueInPrequisiteGroup < ActiveRecord::Migration[5.2]
  def change
    change_column_default :prerequisites, :group_id, 1
  end
end
