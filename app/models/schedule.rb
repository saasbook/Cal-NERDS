require 'json'

class Schedule < ActiveRecord::Base
	belongs_to :user

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
end
