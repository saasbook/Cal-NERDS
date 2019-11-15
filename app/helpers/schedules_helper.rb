module SchedulesHelper
    
    def SchedulesHelper.int_to_4_digit_str i
    	return "%04d" % i
    end
    
    def SchedulesHelper.time_to_string s
    	result = s.to_i
    	int_to_4_digit_str result
    end
    
end