class AddIndexOnCollege < ActiveRecord::Migration[5.2]
  def change
    add_index :colleges, :code
  end
end
