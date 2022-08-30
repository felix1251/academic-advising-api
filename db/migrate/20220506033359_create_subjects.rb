class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :code, null: false
      t.string :description
      t.integer :units, null: false
      t.references :college, foreign_key: true
      t.string :prerequisite_condition
      t.references :curriculum, null: true, foreign_key: true
      t.timestamps
    end
  end
end
