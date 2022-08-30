class AddColumnOnStaff < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :adviser, index: true, null: false, foreign_key: true
  end
end
