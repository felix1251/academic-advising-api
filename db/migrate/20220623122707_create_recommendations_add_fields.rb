class CreateRecommendationsAddFields < ActiveRecord::Migration[5.2]
  def change
    add_column :recommendations, :semester, :integer
  end
end
