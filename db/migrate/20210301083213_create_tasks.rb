class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :admin_id
      t.text :body

      t.timestamps
    end
  end
end
