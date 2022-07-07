class DeleteColumnInCurriculum < ActiveRecord::Migration[5.2]
  def change
    remove_column :curriculums, :department, :text
    remove_column :curriculums, :major_code, :string
  end
end
