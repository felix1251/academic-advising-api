class RemoveReferenceFromSubjects < ActiveRecord::Migration[5.2]
  def change
    remove_reference :subjects, :curriculum, index: true, foreign_key: true
  end
end
