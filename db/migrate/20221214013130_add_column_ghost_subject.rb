class AddColumnGhostSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :ghost, :boolean, :default => false
  end
end
