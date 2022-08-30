class CreateCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculums do |t|
      t.string :code, null: false
      t.string :description
      t.references :college, foreign_key: true
      
      t.timestamps
    end
  end
end
