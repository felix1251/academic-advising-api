class CreatePrerequisites < ActiveRecord::Migration[5.2]
  def change
    create_table :prerequisites do |t|
      t.references :subject, foreign_key: true,  null: false
      t.references :subject_prerequisite, null: false, foreign_key: { to_table: 'subjects' }
      
      t.timestamps
    end
  end
end
