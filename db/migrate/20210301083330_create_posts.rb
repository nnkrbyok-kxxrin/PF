class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :admin_id
      t.string :guest_name
      t.string :guest_name_kana
      t.string :guest_number
      t.string :phone_number
      t.text :address
      t.date :birthday
      t.string :sex
      t.text :allergie
      t.text :profession
      t.string :image_id
      t.text :information

      t.timestamps
    end
  end
end
