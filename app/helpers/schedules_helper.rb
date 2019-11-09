module SchedulesHelper
    
    def SchedulesHelper.int_to_4_digit_str i
    	return "%04d" % i
    end
    	
    def SchedulesHelper.abbrev_to_schemakey abb
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
    
    def SchedulesHelper.time_to_string s
    	if s == "12:00 AM"
    		return "0000"
    	elsif s == "12:30 AM"
    		return "0030"
    	end
    	
    	result = s[0] + s[1] + s[3] + s[4]
    	result = result.to_i
    	if s[-2] == "P" && !(result == 1200 || result == 1230)
    		result += 1200
    	end
    	int_to_4_digit_str result
    end
    
end