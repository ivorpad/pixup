class AddGlobalToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :global, :boolean, default: false
  end
end
