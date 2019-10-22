class AddTimesToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :mon, :string
    add_column :schedules, :tue, :string
    add_column :schedules, :wed, :string
    add_column :schedules, :thu, :string
    add_column :schedules, :fri, :string
    add_column :schedules, :user_id, :string
  end
end
