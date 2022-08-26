class DeleteStaffRef < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :adviser_id
    add_reference :students, :student, index: true, null: false, foreign_key: { to_table: 'staffs' } 
  end
end
