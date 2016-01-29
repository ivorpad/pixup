class AddAssetIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :asset_id, :string
    add_index :comments, :asset_id
  end
end
