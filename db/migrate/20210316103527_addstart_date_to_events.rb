class AddstartDateToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start_time, :datetime
  end
end
