class AddProjectIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :project_id, :integer
  end
end
