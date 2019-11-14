require 'json'

class Schedule < ActiveRecord::Base
	belongs_to :user
	include SchedulesHelper
	
	WEEKDAYS = %w{mon tue wed thu fri}

	def self.parse_times_strings schedule
		times = {}
		for day in ["mon", "tue", "wed", "thu", "fri"]
			sym = "#{day}_times".to_sym
			times_string = schedule.send sym
			if !times_string.nil? && times_string.length != 0
				day_times = JSON.parse times_string
				times[day.to_sym] = day_times
			else
				times[day.to_sym] = []
			end
		end
		return times
	end

	def self.group_weekday array_of_day_time
		weekdays = {"mon_times" => "", 
					"tue_times" => "", 
					"wed_times" => "", 
					"thu_times" => "", 
					"fri_times" => ""}
		for elem in array_of_day_time do
			day = SchedulesHelper.abbrev_to_schemakey(elem[0])
			time = SchedulesHelper.time_to_string(elem[1])
			weekdays[day] = weekdays[day] + time + " "
		end

		weekdays.each do |k, v|
			weekdays[k].strip!
		end

		return weekdays
	end
	
	def self.db_elem_to_map elem 
		daytime_map = Hash.new
		WEEKDAYS.each do |day|
			day_time = "#{day}_times"
			daytime_map[day_time] = elem[day_time.to_sym]
		end
		daytime_map
	end
end
