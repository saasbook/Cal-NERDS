class AddVarTimesToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :mon_var_times, :string
    add_column :schedules, :tue_var_times, :string
    add_column :schedules, :wed_var_times, :string
    add_column :schedules, :thu_var_times, :string
    add_column :schedules, :fri_var_times, :string
  end
end
