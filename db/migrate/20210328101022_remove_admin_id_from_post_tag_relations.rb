class RemoveAdminIdFromPostTagRelations < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_tag_relations, :admin_id, :integer
  end
end
