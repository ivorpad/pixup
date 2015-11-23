class AddAssetFileToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :asset_file_id, :string
  end
end
