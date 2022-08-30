class AddColumnEnrollmentAcademicyear < ActiveRecord::Migration[5.2]
  def change
    add_reference :enrollments, :academic_year, index: true
  end
end
