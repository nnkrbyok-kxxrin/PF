class AddDateAndTimeToGuests < ActiveRecord::Migration[5.2]
  def change
    add_column :guests, :date_and_time, :string
  end
end
