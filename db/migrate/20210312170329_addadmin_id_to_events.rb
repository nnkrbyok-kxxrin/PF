class AddadminIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :admin_id, :integer
  end
end
