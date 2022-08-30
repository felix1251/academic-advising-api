class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :username, null: false
      t.string :password_digest
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
      t.string :suffix, default: ""
      t.string :gender, null: false
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
