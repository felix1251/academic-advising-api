class AddReferenceToDepartments < ActiveRecord::Migration[5.2]
  change_table :departments do |t|
    t.references :college, index: true
  end
end
