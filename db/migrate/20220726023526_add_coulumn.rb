class AddCoulumn < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :email, :string
    add_column :staffs, :username, :string
    add_column :students, :email, :string
    add_column :students, :username, :string
    add_column :admins, :email, :string
    add_column :admins, :username, :string
  end
end
