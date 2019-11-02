require 'json'

class Schedule < ActiveRecord::Base
	belongs_to :user

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

	def self.time_to_string s
		res = s[0] + s[1] + s[3] + s[4]
		res = res.to_i
		if s[-2] == "P" && !(res == 1200 || res == 1230)
			res += 1200
		end
		if s == "12:00 AM"
			return "0000"
		elsif s == "12:30 AM"
			return "0030"
		end
		res.to_s
	end

	def self.group_weekday array_of_arrays
		weekdays = {"mon_times" => "", "tue_times" => "", "wed_times" => "", "thu_times" => "", "fri_times" => ""}
		for one in array_of_arrays do
			key = Schedule.abbrev_to_schemakey(one[0])
			time = Schedule.time_to_string(one[1])
			weekdays[key] = weekdays[key] + time + " "
		end

		weekdays.each do |k, v|
			weekdays[k].strip!
		end

		return weekdays
	end

	def self.abbrev_to_schemakey abb
		if (abb == "M")
			"mon_times"
		elsif (abb == "T")
			"tue_times"
		elsif (abb == "W")
			"wed_times"
		elsif (abb == "R")
			"thu_times"
		elsif (abb == "F")
			"fri_times"
		else
			raise "Has to select a weekday from 9 am to 5 pm"
		end
	end
end
