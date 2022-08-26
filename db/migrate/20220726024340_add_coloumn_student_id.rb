class AddColoumnStudentId < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :id_number, :integer, null: false
  end
end
