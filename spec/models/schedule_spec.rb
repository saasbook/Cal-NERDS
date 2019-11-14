require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'Schedule#parse_times_strings' do
  	it 'should parse some times from a Schedule' do
  		sched = instance_double('Schedule', 
  			mon_times: '["1000", "1030", "1100", "1300", "1330"]',
  			tue_times: nil,
  			wed_times: nil,
  			thu_times: '["1400", "1430", "1500", "1530"]',
  			fri_times: nil
  		)
  		expect(Schedule.parse_times_strings(sched)).to eq({
  			mon: ['1000', '1030', '1100', '1300', '1330'],
  			tue: [],
  			wed: [],
  			thu: ['1400', '1430', '1500', '1530'],
  			fri: []
  		})
  	end
  end
end
