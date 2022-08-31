class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :username, null: false
      t.string :password_digest
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
      t.string :suffix, default: ""
      t.string :gender, null: false
      t.references :college, null: false, foreign_key: true
      t.references :curriculum, null: true, foreign_key: true
      t.boolean :status, default: true
    
      t.timestamps
    end
  end
end
