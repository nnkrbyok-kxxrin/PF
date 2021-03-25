class AddAdminIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :admin_id, :integer
  end
end
