class AddUserColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :id_number, :integer
  end
end
