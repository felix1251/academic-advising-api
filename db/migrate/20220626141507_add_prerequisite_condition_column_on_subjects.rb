class AddPrerequisiteConditionColumnOnSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :prerequisite_condition, :string
  end
end
