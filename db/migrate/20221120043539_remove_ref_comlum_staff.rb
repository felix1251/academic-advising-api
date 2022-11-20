class RemoveRefComlumStaff < ActiveRecord::Migration[5.2]
  def change
    remove_reference :staffs, :curriculum, index: true, foreign_key: true
    add_reference :staffs, :department, index: true, foreign_key: true
  end
end
