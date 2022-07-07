class AddCurriculumFieldDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :curriculums, :department, :text
  end
end
