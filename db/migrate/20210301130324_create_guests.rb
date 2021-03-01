class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.integer :admin_id
      t.string :name
      t.string :name_kana
      t.string :number
      t.string :phone_number
      t.text :address
      t.date :birthday
      t.string :sex
      t.text :allergie
      t.text :profession

      t.timestamps
    end
  end
end
