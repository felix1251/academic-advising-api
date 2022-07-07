class AddReferenceToCurriculum < ActiveRecord::Migration[5.2]
  change_table :curriculums do |t|
    t.references :department, index: true
  end
end
