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
		weekdays = {:mon => [],
					:tue => [],
					:wed => [],
					:thu => [],
					:fri => []}
		
		for elem in array_of_day_time do
			time = SchedulesHelper.time_to_string(elem[1])
			weekdays[elem[0].to_sym] << time
		end

		return weekdays
	end

end
