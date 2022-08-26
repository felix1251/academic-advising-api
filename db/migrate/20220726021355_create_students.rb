class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :password_digest
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
      t.string :suffix, default: ""
      t.string :gender, null: false
      t.references :adviser, null: false, foreign_key: { to_table: 'staff' } 
      t.references :college, null: false, foreign_key: true
      t.references :curriculum, null: false, foreign_key: true
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
