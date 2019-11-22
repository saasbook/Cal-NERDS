class ChangeStartDateToDate < ActiveRecord::Migration
  def change
  	change_column :schedules, :start_date, :date
  end
end
