class CreateSubjectIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :subjects, :code
  end
end
