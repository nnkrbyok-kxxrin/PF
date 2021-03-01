class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :admin_id
      t.integer :guest_id

      t.timestamps
    end
  end
end