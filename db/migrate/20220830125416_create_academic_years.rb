class CreateAcademicYears < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_years do |t|
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
