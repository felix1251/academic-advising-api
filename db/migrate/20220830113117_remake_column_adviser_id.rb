class RemakeColumnAdviserId < ActiveRecord::Migration[5.2]
  def change
    add_reference :staffs, :adviser, index: true, foreign_key: true
  end
end
