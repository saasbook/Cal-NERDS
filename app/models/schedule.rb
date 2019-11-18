require 'json'

class Schedule < ActiveRecord::Base
	belongs_to :user
	include SchedulesHelper

	WEEKDAYS = %w{mon tue wed thu fri}

	def self.weekdays
		return %w{mon tue wed thu fri}
	end

	def self.times
		arr = []
		for i in 9..17
			hour_time = (i * 100).to_s
			half_time = (i * 100 + 30).to_s
			arr << (hour_time.length < 4 ? "0" + hour_time : hour_time)
			arr << (half_time.length < 4 ? "0" + half_time : half_time)
		end
		return arr
	end

	def self.str_to_formatted_time time
		time = DateTime.strptime(time, "%H%M")
		time.strftime("%-I:%M %p")
	end


	def self.parse_times_strings schedule
		times = {}
		for day in ["mon", "tue", "wed", "thu", "fri"]
			sym = "#{day}_times".to_sym
			times_string = schedule.send sym
			if !times_string.nil? && times_string.length != 0
				day_times = JSON.parse times_string
				times[sym] = day_times
			else
				times[sym] = []
			end
			sym = "#{day}_var_times".to_sym
			times_string = schedule.send sym
			if !times_string.nil? && times_string.length != 0
				day_times = JSON.parse times_string
				times[sym] = day_times
			else
				times[sym] = []
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
