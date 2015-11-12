class AddSlugToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :slug, :string
    add_index :assets, :slug, unique: true
  end
end
