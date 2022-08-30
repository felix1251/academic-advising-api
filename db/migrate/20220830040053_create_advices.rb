class CreateAdvices < ActiveRecord::Migration[5.2]
  def change
    create_table :advices do |t|
      t.references :staff
      t.references :student
      t.text :message
      t.text :subject_ids
      t.timestamps
    end
  end
end
