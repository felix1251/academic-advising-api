class CreatePrerequisites < ActiveRecord::Migration[5.2]
  def change
    create_table :prerequisites do |t|
      t.references :subject, foreign_key: true,  null: false, :on_delete => :cascade
      t.references :subject_prerequisite, null: false, foreign_key: { to_table: 'subjects' }, :on_delete => :cascade
      
      t.timestamps
    end
  end
end
