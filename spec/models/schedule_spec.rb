require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'parse_times_strings' do
  	it 'should parse some times from a Schedule' do
  		sched = instance_double('Schedule', 
  			mon_times: '["1000", "1030", "1100", "1300", "1330"]',
  			tue_times: nil,
  			wed_times: nil,
  			thu_times: '["1400", "1430", "1500", "1530"]',
  			fri_times: nil,
        mon_var_times: nil,
        tue_var_times: nil,
        wed_var_times: nil,
        thu_var_times: '["1500", "1530"]',
        fri_var_times: '["0900", "0930", "1000", "1030"]',
  		)
  		expect(Schedule.parse_times_strings(sched)).to eq({
  			mon_times: ['1000', '1030', '1100', '1300', '1330'],
  			tue_times: [],
  			wed_times: [],
  			thu_times: ['1400', '1430', '1500', '1530'],
  			fri_times: [],
        mon_var_times: [],
        tue_var_times: [],
        wed_var_times: [],
        thu_var_times: ['1500', '1530'],
        fri_var_times: ['0900', '0930', '1000', '1030'],
  		})
  	end
  end
end
