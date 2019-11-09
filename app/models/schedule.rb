require 'json'

class Schedule < ActiveRecord::Base
	belongs_to :user
	include SchedulesHelper

	def self.parse_times_strings schedule
		times = {}
		for day in ["mon", "tue", "wed", "thu", "fri"]
			sym = "#{day}_times".to_sym
			times_string = schedule.send sym
			if !times_string.nil?
				day_times = JSON.parse times_string
				times[day.to_sym] = day_times
			else
				times[day.to_sym] = []
			end
		end
		return times
	end

	def self.group_weekday array_of_arrays
		weekdays = {"mon_times" => "", 
					"tue_times" => "", 
					"wed_times" => "", 
					"thu_times" => "", 
					"fri_times" => ""}
		for one in array_of_arrays do
			key = SchedulesHelper.abbrev_to_schemakey(one[0])
			time = SchedulesHelper.time_to_string(one[1])
			weekdays[key] = weekdays[key] + time + " "
		end

		weekdays.each do |k, v|
			weekdays[k].strip!
		end

		return weekdays
	end
	
end
