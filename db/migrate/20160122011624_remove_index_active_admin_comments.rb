class RemoveIndexActiveAdminComments < ActiveRecord::Migration
  def change
    remove_index(:active_admin_comments, :name => 'index_active_admin_comments_on_author_type_and_author_id')
    remove_index(:active_admin_comments, :name => 'index_active_admin_comments_on_namespace')
    remove_index(:active_admin_comments, :name => 'index_active_admin_comments_on_resource_type_and_resource_id')
  end
end
