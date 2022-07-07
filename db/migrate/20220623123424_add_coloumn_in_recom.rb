class AddColoumnInRecom < ActiveRecord::Migration[5.2]
  def change
    add_column :recommendations, :year, :integer
  end
end
