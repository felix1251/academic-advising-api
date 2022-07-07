class AddMajorCodeToCurriculums < ActiveRecord::Migration[5.2]
  def change
    add_column :curriculums, :major_code, :string
  end
end
