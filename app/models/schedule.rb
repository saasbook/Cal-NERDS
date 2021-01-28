require 'json'

class Schedule < ActiveRecord::Base
	belongs_to :user
	include SchedulesHelper

	WEEKDAYS = %w{mon tue wed thu fri}
	WEEKDAYS_FULL = %w{monday tuesday wednesday thursday friday}

	def self.calculate_hours starting, ending
		schedules = Schedule.where(start_date: starting.beginning_of_day..ending.end_of_day)
		half_hours = 0
		schedules.each do |s|
			%w(mon tue wed thu fri).each do |day|
				begin
					times = JSON.parse s.send (day + "_times").to_sym
				rescue
					times = []
				end
				begin
					var_times = JSON.parse s.send (day + "_var_times").to_sym
				rescue
					var_times = []
				end
				half_hours += times.length + var_times.length
			end
		end
		return half_hours / 2.0
	end

	def self.weekdays
		return WEEKDAYS
	end

	# Returns all valid work times
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

	# Finds corresponding times for given user and week start date
	def self.get_user_time_strings(user, date)
		schedule = Schedule.where(user_id: user.id).where(start_date: date).first
		self.parse_times_strings schedule unless schedule.nil?
	end
	
	# Converts database string format to hash with day key values
	def self.parse_times_strings schedule
		times = {}
		for day in WEEKDAYS
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
		weekdays = {
			:mon_times => [],
			:tue_times => [],
			:wed_times => [],
			:thu_times => [],
			:fri_times => [],
			:mon_var_times => [],
			:tue_var_times => [],
			:wed_var_times => [],
			:thu_var_times => [],
			:fri_var_times => []
		}
		
		for elem in array_of_day_time do
			time = SchedulesHelper.time_to_string(elem[1])
			if elem[2] == "true"
				weekdays[(elem[0] + "_var_times").to_sym] << time
			else
				weekdays[(elem[0] + "_times").to_sym] << time
			end
		end

		return weekdays
	end
	
	def self.has_no_schedules
		Schedule.first.nil?
	end

	def self.find_by_start_date schedule
		Schedule.where(user_id: schedule.user_id).where(start_date: schedule.start_date)[0]
	end

	def self.start_date_exists? schedule
		Schedule.where(user_id: schedule.user_id).where(start_date: schedule.start_date).length > 0
	end

	def self.is_monday? date
		date.monday?
	end
end
