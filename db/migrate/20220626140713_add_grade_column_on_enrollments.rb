class AddGradeColumnOnEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_column :enrollments, :grade, :string, default: ""
  end
end
