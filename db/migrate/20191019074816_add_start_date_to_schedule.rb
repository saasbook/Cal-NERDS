class AddStartDateToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :start_date, :string
  end
end
