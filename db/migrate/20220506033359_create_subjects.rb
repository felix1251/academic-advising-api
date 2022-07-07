class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :code, null: false
      t.string :description
      t.integer :units, null: false
      t.references :college, foreign_key: true , :on_delete => :cascade
      t.references :curriculum, null: true, foreign_key: true , :on_delete => :cascade
      t.timestamps
    end
  end
end
