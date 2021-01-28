module SchedulesHelper
    
    def SchedulesHelper.int_to_4_digit_str i
    	"%04d" % i
    end
    
    def SchedulesHelper.time_to_string s
    	int_to_4_digit_str s.to_i
    end
    
end