class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :title
      t.references :user, foreign_key: true , :on_delete => :cascade
      
      t.timestamps
    end
  end
end
