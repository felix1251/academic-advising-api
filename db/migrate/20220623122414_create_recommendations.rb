class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.references :subject, index: true, foreign_key: true,  null: false
      t.references :curriculum, index: true, foreign_key: true,  null: false
      t.timestamps
    end
  end
end
