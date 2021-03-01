class CreateAddInfomations < ActiveRecord::Migration[5.2]
  def change
    create_table :add_infomations do |t|
      t.integer :admin_id
      t.integer :post_id
      t.string :image_id
      t.text :infomation

      t.timestamps
    end
  end
end
