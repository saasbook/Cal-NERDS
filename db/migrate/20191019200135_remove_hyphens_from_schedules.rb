class RemoveHyphensFromSchedules < ActiveRecord::Migration
  def change
  	remove_column :schedules, "mon-times".to_sym, :string
    remove_column :schedules, "tue-times".to_sym, :string
    remove_column :schedules, "wed-times".to_sym, :string
    remove_column :schedules, "thu-times".to_sym, :string
    remove_column :schedules, "fri-times".to_sym, :string
  end
end
