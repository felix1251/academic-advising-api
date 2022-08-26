class DeleteStaffRef2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :student_id
    add_reference :students, :adviser, index: true, null: false, foreign_key: { to_table: 'staffs' } 
  end
end
