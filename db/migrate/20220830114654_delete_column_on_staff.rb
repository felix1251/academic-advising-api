class DeleteColumnOnStaff < ActiveRecord::Migration[5.2]
  def change
    remove_column :staffs, :adviser_id
    remove_column :students, :adviser_id
  end
end
