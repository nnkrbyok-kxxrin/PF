class AddDateAndTimeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :date_and_time, :string
  end
end
