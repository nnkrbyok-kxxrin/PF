class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :admin_id
      t.integer :guest_id
      t.string :image_id
      t.text :infomation

      t.timestamps
    end
  end
end
