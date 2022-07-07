class CreateColleges < ActiveRecord::Migration[5.2]
  def change
    create_table :colleges do |t|
      t.string :code, default: '', null: false
      t.string :description
      
      t.timestamps
    end
  end
end
