class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.references :subject, index: true, foreign_key: true,  null: false, :on_delete => :cascade
      t.references :curriculum, index: true, foreign_key: true,  null: false, :on_delete => :cascade
      t.timestamps
    end
  end
end
