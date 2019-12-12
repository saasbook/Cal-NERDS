class RemoveBadTimesFromSchedule < ActiveRecord::Migration
  def change
  	remove_column :schedules, :mon, :string
    remove_column :schedules, :tue, :string
    remove_column :schedules, :wed, :string
    remove_column :schedules, :thu, :string
    remove_column :schedules, :fri, :string
    add_column :schedules, :mon_times, :string
    add_column :schedules, :tue_times, :string
    add_column :schedules, :wed_times, :string
    add_column :schedules, :thu_times, :string
    add_column :schedules, :fri_times, :string
  end
end
