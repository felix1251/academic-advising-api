class AddGroupIdPrereq < ActiveRecord::Migration[5.2]
  def change
    add_column :prerequisites, :group_id, :integer, :default => 1
  end
end
