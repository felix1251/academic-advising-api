class CreateMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :majors do |t|
      t.string :description
      t.references :college, foreign_key: true
      t.references :curriculum, null: true, foreign_key: true
      t.timestamps
    end
  end
end
