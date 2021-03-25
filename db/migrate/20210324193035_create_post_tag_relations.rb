class CreatePostTagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tag_relations do |t|
      t.integer :admin_id
      t.integer :post_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
