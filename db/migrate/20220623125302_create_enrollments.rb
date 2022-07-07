class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.references :enrolled, null: false, foreign_key: { to_table: 'subjects' }, :on_delete =>:cascade
      t.references :student, null: false, foreign_key: { to_table: 'users' }, :on_delete =>:cascade
      t.integer :sem, null: false
      t.datetime :datetime_enrolled, null: false
      t.timestamps
    end
  end
end
