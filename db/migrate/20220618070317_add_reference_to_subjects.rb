class AddReferenceToSubjects < ActiveRecord::Migration[5.2]
  change_table :subjects do |t|
    t.references :department, index: true
  end
end
