class DeleteColumnOnStaffAdviserId < ActiveRecord::Migration[5.2]
  def change
    remove_column :staffs, :adviser_id
  end
end
