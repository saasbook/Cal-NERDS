class ChangeStartDateToDate < ActiveRecord::Migration
  def change
  	change_column :schedules, :start_date, 'text USING CAST(start_date AS text)'
  end
end
