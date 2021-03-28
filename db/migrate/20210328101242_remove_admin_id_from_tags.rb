class RemoveAdminIdFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :tags, :admin_id, :integer
  end
end
