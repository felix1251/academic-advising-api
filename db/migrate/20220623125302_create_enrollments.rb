class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.references :enrolled, null: false, foreign_key: { to_table: 'subjects' }
      t.references :student, null: false
      t.integer :sem, null: false
      t.string :grade, :default => ""
      t.datetime :datetime_enrolled, null: false
      t.timestamps
    end
  end
end
