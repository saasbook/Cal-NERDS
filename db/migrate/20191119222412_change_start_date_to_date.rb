class ChangeStartDateToDate < ActiveRecord::Migration
  def change
  	if Rails.env.production?
	  	change_column :schedules, :start_date, 'date USING CAST(start_date AS date)'
	  else
	  	change_column :schedules, :start_date, :datetime
	  end
  end
end
