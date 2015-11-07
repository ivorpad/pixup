class AddAssetToCategorization < ActiveRecord::Migration
  def change
    add_column :categorizations, :asset_id, :integer
  end
end
