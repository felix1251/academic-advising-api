class Delete < ActiveRecord::Migration[5.2]
  def change
    remove_column :enrollments, :student_id
    add_reference :enrollments, :student, index: true
  end
end
