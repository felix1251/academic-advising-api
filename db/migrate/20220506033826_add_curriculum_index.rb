class AddCurriculumIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :curriculums, :code
  end
end
