require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'parse_times_strings' do
  	it 'should parse some times from a Schedule into a hash' do
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

  describe 'calculate_hours' do
    before :each do
      @schedules = [
        Schedule.create(id: 1, start_date: Date.parse('2019-12-02'), user_id: 3, mon_times: "[1000, 1030, 1100, 1130]", wed_times: "[1000, 1030, 1100, 1600, 1630]"),
        Schedule.create(id: 2, start_date: Date.parse('2019-12-02'), user_id: 3, mon_times: "[1000, 1030, 1100, 1130]"),
        Schedule.create(id: 3, start_date: Date.parse('2019-12-09'), user_id: 3, mon_times: "[1000, 1030, 1100, 1130]"),
        Schedule.create(id: 4, start_date: Date.parse('2019-12-16'), user_id: 3, mon_times: "[1000, 1030, 1100, 1130]"),
        Schedule.create(id: 5, start_date: Date.parse('2019-12-09'), user_id: 3, mon_times: "[1000, 1030, 1100, 1130]"),
      ]
    end

    it 'should calculate hours' do
      expect(Schedule.calculate_hours Date.parse('2019-12-02'), Date.parse('2019-12-08')).to eq(6.5)
      expect(Schedule.calculate_hours Date.parse('2019-12-02'), Date.parse('2019-12-15')).to eq(10.5)
      expect(Schedule.calculate_hours Date.parse('2019-12-09'), Date.parse('2019-12-17')).to eq(6)
    end
  end
end
