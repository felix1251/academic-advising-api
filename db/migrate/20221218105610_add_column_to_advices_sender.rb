class AddColumnToAdvicesSender < ActiveRecord::Migration[5.2]
  def change
    add_column :advices, :sender, :string, null: false, :length => 1
  end
end
