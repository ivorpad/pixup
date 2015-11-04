class RemoveCommentAndFileIdFromAsset < ActiveRecord::Migration
  def change
    remove_column :assets, :comment, :text
    remove_column :assets, :file_id, :string
  end
end
